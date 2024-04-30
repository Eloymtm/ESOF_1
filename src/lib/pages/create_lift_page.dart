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

class _CreateLiftPageState extends State<CreateLiftPage> {

  final LocalPartida= TextEditingController();
  final LocalDestino = TextEditingController();
  final DataPartida = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                SizedBox(height: 60,),
                Text("Local de partida"),
                EditableNameField(
                  sufixIcon: FontAwesomeIcons.locationDot,
                  showSuffixButton: false,
                  controller: LocalPartida,
                ),
                SizedBox(height: 60,),
                Text("Local de origem"),
                EditableNameField(
                  sufixIcon: FontAwesomeIcons.locationDot,
                  showSuffixButton: false,
                  controller: LocalDestino,
                ),
                SizedBox(height: 60,),
                Text("Data de partida"),
                EditableNameField(
                  sufixIcon: FontAwesomeIcons.clock,
                  showSuffixButton: false,
                  controller: DataPartida,
                ),
                 SizedBox(height: 60,),
                Text("Escolhe o teu carro"),
                EditableNameField(
                  sufixIcon: FontAwesomeIcons.clock,
                  showSuffixButton: false,
                  controller: DataPartida,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: ButtonWidget(
                      text: 'Criar viagem',
                      onClicked: () {},
                      padH: 120,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
