import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/components/autocomplete.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:intl/intl.dart';
import 'package:src/pages/profile/appbar_widget.dart';
import 'package:src/pages/profile/button_widget.dart';
import 'package:src/pages/profile/edit_field_widget.dart';

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
                const SizedBox(height: 30,),
                const Text("Local de partida"),
                GooglePlacesAutoCompleteField(
                  controller: LocalPartida,
                  googleAPIKey: googleApiKey, 
                ),
                const SizedBox(height: 30,),
                const Text("Local de destino"),
                GooglePlacesAutoCompleteField(
                  controller: LocalDestino,
                  googleAPIKey: googleApiKey, 
                ),
                const SizedBox(height: 30,),
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
                      borderRadius: BorderRadius.circular(_borderRadius), // Menos arredondado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(_borderRadius - 5.0), // Menos arredondado
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectTime();
                  },
                ),
                const SizedBox(height: 30,),
                const Text("Carro"),
                TextFormField(
                  controller: Car,
                  decoration: InputDecoration(
                    labelText: 'Seleciona o teu carro',
                    suffixIcon: Icon(FontAwesomeIcons.car),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    createRide(Car.text, LocalDestino.text, LocalPartida.text, DateController.text, TimeController.text);
                    // Mostra uma mensagem de sucesso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viagem criada com sucesso')),
                    );
                    // Redireciona para outra página
                    // Navigator.pushNamed(context, '');
                  },
                  child: Text('Criar viagem'),
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
        lastDate: DateTime(2100)
    );

    if(_picked != null){
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
