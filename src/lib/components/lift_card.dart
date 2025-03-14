
import 'package:flutter/material.dart';


class Lift_card extends StatelessWidget {
  final String partida;
  final String destino;
  final String horaPartida;
  final String condutor;
  final int NumPassageiros;
  final VoidCallback onTap;
  

  const Lift_card({
    super.key,
    required this.destino,
    required this.partida,
    required this.horaPartida,
    required this.condutor,
    required this.NumPassageiros,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[100]!, const Color.fromARGB(255, 255, 185, 128)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.all(16.0),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'De: $partida',
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 3),
            Text(
              'Para: $destino',
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              'Hora de Partida: $horaPartida',
              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              'Condutor: $condutor',
              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              'Ocupação: $NumPassageiros / 5',
              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
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
      ),
    );
  }
}