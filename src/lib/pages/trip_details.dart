import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/pages/profile/numbers_widget.dart';

class TripDetailsPage extends StatelessWidget {
  final String destino;
  final String partida;
  final String horaPartida;
  final DocumentSnapshot refCond;
  final int numPassageiros;

  TripDetailsPage({
    required this.destino,
    required this.partida,
    required this.horaPartida,
    required this.refCond,
    required this.numPassageiros,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da Viagem',
          style: TextStyle(
              color: Color.fromRGBO(246, 161, 86, 1),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ), 
        ),
        centerTitle:true,
        
        backgroundColor: Colors.white,
        elevation: 0, // Remove a sombra do AppBar
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Material(
                  child: Ink.image(
                image:NetworkImage(refCond['ImagePath']),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              )
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                refCond['Name'],
                style: const TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
              ),
            ),
           Center(
              child: Text(
                refCond['Email'],
                style: const TextStyle(fontSize: 17.0),
              ),
            ),
            NumbersWidget(rating: (refCond['Rating'])),
            const SizedBox(height: 20),
            const Text(
              'Partida',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              partida,
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Destino',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              destino,
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Hora de Partida',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              horaPartida,
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 20.0),
            const Text(
              'Número de Passageiros',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              numPassageiros.toString(),
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Adicione aqui a lógica para participar da viagem
                  Navigator.pushNamed(context, '/singleRide_page');
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontWeight: FontWeight.w900,fontSize: 25),
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.orange[500],// Cor do botão
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'ENTRAR NA VIAGEM',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}