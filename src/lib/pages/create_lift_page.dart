import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/components/autocomplete.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:intl/intl.dart';
import 'package:src/pages/profile/button_widget.dart';


class CreateLiftPage extends StatefulWidget {
  const CreateLiftPage({super.key});

  @override
  State<CreateLiftPage> createState() => _CreateLiftPageState();
}
  Timestamp createTimestamp(String Date, String Time){
    final dateTimeString = '$Date $Time';
    final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm');
    DateTime dateTime = dateTimeFormat.parse(dateTimeString);
    // Adjust for UTC+1 (if necessary)
    dateTime = dateTime.add(Duration(hours: 1));

    // Return the Timestamp from Firestore
    return Timestamp.fromDate(dateTime);
  }

 Future createRide(String Car, String destino, String partida,String Date,String Time) async{
   final currentUser = FirebaseAuth.instance.currentUser!;
   final DataPartida = createTimestamp(Date, Time);
    List<DocumentReference> passageiros = [];

   final rideId = FirebaseFirestore.instance.collection('Ride').doc().id; //gerar id
   final userRef = FirebaseFirestore.instance.collection('User').doc(currentUser.uid); //ir buscar o user
   passageiros.add(userRef);
    await FirebaseFirestore.instance.collection('Ride').doc(rideId).set(
        {
          'Driver' : userRef,
          'Destino' :destino,
          'Partida' : partida,
          'HoraPartida' :DataPartida,
          'Car' : Car,
          'passageiros': passageiros,
        }
    );
 }

class _CreateLiftPageState extends State<CreateLiftPage> {
  final LocalPartida = TextEditingController();
  final LocalDestino = TextEditingController();
  final DataPartida = TextEditingController();
  final Car = TextEditingController();

  String? _selectedCar;
  TextEditingController TimeController = TextEditingController();
  TextEditingController DateController = TextEditingController();
  double _borderRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
        title: const Padding(
          padding: EdgeInsets.symmetric(),
          child: Text(
            "UNILIFT",
            style: TextStyle(
              color: Color.fromRGBO(246, 161, 86, 1),
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("Local de partida"),
                GooglePlacesAutoCompleteField(
                  controller: LocalPartida,
                  googleAPIKey: googleApiKey, 
                ),
                const SizedBox(height: 30),
                const Text("Local de destino"),
                GooglePlacesAutoCompleteField(
                  controller: LocalDestino,
                  googleAPIKey: googleApiKey,
                ),
                const SizedBox(height: 30),
                const Text("Data de partida"),
                TextField(
                  controller: DateController,
                  decoration: InputDecoration(
                    labelText: 'DATA',
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(_borderRadius - 5.0),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                ),
                const SizedBox(height: 10),
                const Text("Hora de partida"),
                TextField(
                  controller: TimeController,
                  decoration: InputDecoration(
                    labelText: 'HORA',
                    filled: true,
                    prefixIcon: const Icon(Icons.access_time),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(_borderRadius - 5.0),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectTime();
                  },
                ),
                const SizedBox(height: 30),
                const Text("Escolhe o teu carro"),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Car')
                      .where('user', isEqualTo: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erro ao carregar carros: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('Nenhum carro encontrado');
                    } else {
                      List<DropdownMenuItem<String>> carItems = snapshot.data!.docs.map((doc) {
                        var carData = doc.data() as Map<String, dynamic>;
                        return DropdownMenuItem<String>(
                          value: doc.id,
                          child: Text('${carData['marca']} ${carData['modelo']}'),
                        );
                      }).toList();

                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        value: _selectedCar,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCar = newValue;
                          });
                        },
                        items: carItems,
                        validator: (value) => value == null ? 'Escolha um carro' : null,
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  text: 'Criar viagem',
                  onClicked: () {
                    if (_selectedCar != null) {
                      createRide(_selectedCar!, LocalDestino.text, LocalPartida.text, DateController.text, TimeController.text);
                      // Mostra uma mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Viagem criada com sucesso')),
                      );
                      // Redireciona para outra página
                      // Navigator.pushNamed(context, '');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Por favor, escolha um carro')),
                      );
                    }
                  },
                  padH: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        DateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        TimeController.text = pickedTime.format(context);
      });
    }
  }
}
