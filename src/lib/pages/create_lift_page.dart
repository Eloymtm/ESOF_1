import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/pages/profile/appbar_widget.dart';
import 'package:src/pages/profile/button_widget.dart';
import 'package:src/pages/profile/edit_field_widget.dart';

class CreateLiftPage extends StatefulWidget {
  const CreateLiftPage({super.key});

  @override
  State<CreateLiftPage> createState() => _CreateLiftPageState();
}


 Future createRide(String destino, String partida,String DataPartida) async{
   final currentUser = FirebaseAuth.instance.currentUser!;

   final rideId = FirebaseFirestore.instance.collection('Ride').doc().id; //gerar id
    final userRef = FirebaseFirestore.instance.collection('User').doc(currentUser.uid); //ir buscar o user
    await FirebaseFirestore.instance.collection('Ride').doc(rideId).set(
        {
          'Driver' : userRef,
          'Destino' :destino,
          'Partida' : partida,
          
        }
    );
 }

class _CreateLiftPageState extends State<CreateLiftPage> {

  final LocalPartida= TextEditingController();
  final LocalDestino = TextEditingController();
  final DataPartida = TextEditingController();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController =TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal:20),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Local de partida"),
            TextFormField(
              controller: LocalPartida,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                prefix: Padding(
                  padding: EdgeInsets.only(right: 15, bottom: 5),
                  //child: Icon(FontAwesomeIcons.locationDot),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2.0, color: primaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                suffix: Icon(FontAwesomeIcons.locationDot),

              ),
              cursorColor: primaryColor,
            ),

                SizedBox(height: 30,),
                Text("Local de origem"),
                EditableNameField(
                  onEditPressed: (){
                    Navigator.pushNamed(context, '/choose_location_page');
                  },
                  sufixIcon: FontAwesomeIcons.locationDot,
                  showSuffixButton: false,
                  controller: LocalDestino,
                ),
                SizedBox(height: 30,),
                Text("Data de partida"),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'DATA',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(_borderRadius - 5.0),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                ),
                SizedBox(height: 10), // Adiciona espaçamento entre os campos
                Text("Hora de partida"),
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'HORA',
                    filled: true,
                    prefixIcon: Icon(Icons.access_time),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(_borderRadius), // Menos arredondado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(_borderRadius - 5.0), // Menos arredondado
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectTime();
                  },
                ),
                 SizedBox(height: 30,),
                Text("Escolhe o teu carro"),
                EditableNameField(
                  sufixIcon: FontAwesomeIcons.clock,
                  showSuffixButton: false,
                  controller: DataPartida,
                ),
                SizedBox(height: 30,),
                ButtonWidget(
                    text: 'Criar viagem',
                    onClicked: () {
                      createRide(LocalDestino.text, LocalPartida.text, DataPartida.text);
                      // Mostra uma mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viagem criada com sucesso')),
                      );
                      // Redireciona para outra página
                      // Navigator.pushNamed(context, '');
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
        lastDate: DateTime(2100)
    );

    if(_picked != null){
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
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
        _timeController.text = pickedTime.format(context);
      });
    }
  }
}
