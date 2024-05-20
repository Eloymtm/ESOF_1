import 'dart:ffi';

import 'package:flutter/material.dart';


class Lift_card extends StatelessWidget {
  final String partida;
  final String destino;
  final String horaPartida;
  final String condutor;
  final int NumPassageiros;

  const Lift_card({
    super.key,
    required this.destino,
    required this.partida,
    required this.horaPartida,
    required this.condutor,
    required this.NumPassageiros,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[100]!, const Color.fromARGB(255, 255, 185, 128)!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'De: $partida',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 3),
            Text(
              'Para: $destino',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              'Hora de Partida: $horaPartida',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              'Condutor: $condutor',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              'Passageiros: $NumPassageiros / 5',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            /*
            SizedBox(height: 8),
            Text(
              'Condutor: $nomeCondutor',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            */
          ],
        ),
        onTap: () {
          // Adicione a lógica onTap, se necessário
        },
      ),
    );
  }
}