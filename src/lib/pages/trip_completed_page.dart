import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/helper/helper_method.dart';
import 'package:src/pages/profile/numbers_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TripCompletedPage extends StatefulWidget {
  final DocumentSnapshot refRide;

  const TripCompletedPage({Key? key, required this.refRide}) : super(key: key);

  @override
  TripCompletedState createState() => TripCompletedState();
}

class TripCompletedState extends State<TripCompletedPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  late final DocumentSnapshot refRide;
  late final DocumentReference refCond;
  late final String destino;
  late final String partida;
  late final horaPartida;
  late final numPassageiros;
  Map<String, dynamic>? driver; // Inicializa como nulo
  bool isLoading = true; // Estado para controlar o carregamento
  double rating = 0.0; // Estado para armazenar a avaliação do usuário
  bool ratingSubmitted = false; // Estado para controlar se a avaliação foi enviada
  bool ratingUpdated = false; // Estado para controlar se o rating do condutor foi atualizado

  @override
  void initState() {
    super.initState();
    refRide = widget.refRide;
    refCond = refRide['Driver'];
    destino = refRide['Destino'];
    partida = refRide['Partida'];
    horaPartida = formatData(refRide['HoraPartida']);
    numPassageiros = refRide['passageiros'].length;
    _fetchDriverData();
  }

  Future<void> _fetchDriverData() async {
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
      setState(() {
        isLoading = false; // Mesmo em caso de erro, para de carregar
      });
    }
  }

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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      style: const TextStyle(
                          fontSize: 27.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      driver!['Email'],
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ),
                  NumbersWidget(rating: (driver!['Rating'])),
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
                  const Text(
                    'Número de Passageiros',
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    numPassageiros.toString(),
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 30.0),
                  if (!ratingUpdated && currentUser.uid! != refCond.id) ...[
                    const Text(
                      'Avalie sua viagem',
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          this.rating = rating;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _submitRating();
                        },
                        child: const Text('Enviar Avaliação'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  bool _isTripCompleted() {
    // Verifica se a viagem já terminou há mais de 1 dia
    DateTime tripStartTime = refRide['HoraPartida'].toDate();
    DateTime now = DateTime.now();
    return now.isAfter(tripStartTime.add(Duration(days: 1)));
  }

    Future<void> _submitRating() async {
    // Verifica se já passou um dia desde o início da viagem
    if (!_isTripCompleted()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você só pode avaliar a viagem após 1 dia do término.')),
      );
      return;
    }

    try {
      // Atualizar o rating do condutor no Firestore
      double currentRating = driver!['Rating'] != null ? driver!['Rating'] : 0.0;
      int totalRatings = driver!['TotalRatings'] != null ? driver!['TotalRatings'] : 0;

      // Adicionar o novo rating ao total e incrementar o número total de avaliações
      double newRating = ((currentRating * totalRatings) + rating) / (totalRatings + 1);

      // Atualizar os dados do condutor
      await refCond.update({
        'Rating': newRating,
        'TotalRatings': totalRatings + 1,
      });

      setState(() {
        ratingUpdated = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Avaliação salva com sucesso!')),
      );
    } catch (e) {
      print("Erro ao salvar avaliação: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ocorreu um erro ao salvar a avaliação. Tente novamente mais tarde.')),
      );
    }
  }
}