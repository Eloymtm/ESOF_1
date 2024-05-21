import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/helper/helper_method.dart';
import 'package:src/pages/profile/numbers_widget.dart';

class TripDetailsPage extends StatefulWidget {
  final DocumentSnapshot refRide;

  const TripDetailsPage({Key? key, required this.refRide}) : super(key: key);

  @override
  State<TripDetailsPage> createState() => TripDetailsState();
}

class TripDetailsState extends State<TripDetailsPage> {
  late final DocumentSnapshot refRide;
  late final DocumentReference refCond;
  late final String destino;
  late final String partida;
  late final horaPartida;
  late final numPassageiros;
  Map<String, dynamic>? driver; // Inicializa como nulo

  bool isLoading = true; // Estado para controlar o carregamento

  @override
  void initState() {
    super.initState();
    refRide = widget.refRide;
    refCond = refRide['Driver'];
    destino = refRide['Destino'];
    partida = refRide['Partida'];
    horaPartida = formatData(refRide['HoraPartida']);
    numPassageiros = refRide['passageiros'].length;

    fetchDriverData();
  }

  Future<void> fetchDriverData() async {
    try {
      DocumentSnapshot driverSnapshot = await refCond.get();
      if (driverSnapshot.exists) {
        setState(() {
          driver = driverSnapshot.data() as Map<String, dynamic>;
          isLoading = false; // Marca isLoading como falso quando os dados são carregados
        });
      }
    } catch (e) {
      // Trate o erro apropriadamente, talvez exibindo uma mensagem ao usuário
      print("Erro ao buscar dados do motorista: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Se isLoading for verdadeiro, exibe o indicador de progresso
    if (isLoading) {
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
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      // Se isLoading for falso, os dados do motorista estão prontos, então exibe a interface do usuário
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
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Se driver não for nulo, exibe os detalhes do motorista
              if (driver != null) ...[
                Center(
                  child: ClipOval(
                    child: Material(
                      child: Ink.image(
                        image: NetworkImage(driver!['ImagePath']),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    driver!['Name'],
                    style: const TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    driver!['Email'],
                    style: const TextStyle(fontSize: 17.0),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Partida',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  partida,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Destino',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  destino,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hora de Partida',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  horaPartida,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                const Text(
                  'Número de Passageiros',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  numPassageiros.toString(),
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione aqui a lógica para participar da viagem
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.w900,fontSize: 25),
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.orange[500], // Cor do botão
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
            ],
          ),
        ),
      );
    }
  }}