import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/pages/trip_completed_page.dart';

import 'chat/chat_page10.dart';

class HistoricPage   extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _MyLiftsPageState();
}

class _MyLiftsPageState extends State<HistoricPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _currentUser;
  late DocumentReference userRef;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser!;
    userRef = _firestore.collection('User').doc(_currentUser.uid);
  }

  Stream<QuerySnapshot> _getLiftsAsDriver() {
    return _firestore.collection('Ride')
        .where('Driver', isEqualTo: userRef)
        .snapshots();
  }

  Stream<QuerySnapshot> _getLiftsAsPassenger() {
    return _firestore.collection('Ride')
        .where('passageiros', arrayContains: userRef)
        .snapshots();
  }

  bool _isUpcomingOrRecent(Timestamp timestamp) {
    final liftTime = timestamp.toDate();
    final now = DateTime.now();
    final isSameDay = liftTime.year == now.year && liftTime.month == now.month && liftTime.day == now.day;
    final isUpcoming = liftTime.isAfter(now);
    final isRecent = isSameDay && now.difference(liftTime).inMinutes <= 30;
    return isUpcoming || isRecent;
  }

  Future<void> _cancelLift(String liftId) async {
    await _firestore.collection('Ride').doc(liftId).delete();
  }

  Future<void> _leaveLift(String liftId) async {
    await _firestore.collection('Ride').doc(liftId).update({
      'passageiros': FieldValue.arrayRemove([userRef])
    });
  }

  Widget _buildLiftCard(DocumentSnapshot doc, bool como) {
    final liftTime = (doc['HoraPartida'] as Timestamp).toDate();
    final bool isDriver = doc['Driver'] == userRef && como;
    final referenciaCondutor = doc['Car'];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: FutureBuilder<DocumentSnapshot>(
        future: referenciaCondutor.get(),
        builder: (context, driverSnapshot) {
          if (!driverSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final CarData = driverSnapshot.data!;
          final marcaRide = CarData['marca'];

          return ListTile(
            title: Text(doc['Destino'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Partida: ${doc['Partida']}'),
                Text('Hora: ${liftTime.toLocal()}'),
                Text('Carro: $marcaRide'),
              ],
            ),
            onTap:() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TripCompletedPage(
                                      refRide: doc,
                                    ),
                                  ),
                                )
          );
        },
      ),
    );
  }


  Widget _buildLiftList(AsyncSnapshot<QuerySnapshot> snapshot, bool como) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    final lifts = snapshot.data!.docs.where((doc) {
      final liftTime = doc['HoraPartida'] as Timestamp;
      return _isUpcomingOrRecent(liftTime);
    }).toList();

    if (lifts.isEmpty) {
      return const Center(child: Text('Não tens nenhuma viagem.'));
    }

    return ListView.builder(
      itemCount: lifts.length,
      itemBuilder: (context, index) {
        return _buildLiftCard(lifts[index], como);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,  // Número de abas
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),  
          title: const Text(
          "Histórico de Viagens",
          style: TextStyle(fontSize: 25, color: Color.fromRGBO(246, 161, 86, 1), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Como Condutor'),
                Tab(text: 'Como Passageiro'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Como Condutor
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _getLiftsAsDriver(),
                      builder: (context, snapshot) {
                        return _buildLiftList(snapshot, true);
                      },
                    ),
                  ),
                ],
              ),
              // Como Passageiro
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _getLiftsAsPassenger(),
                      builder: (context, snapshot) {
                        return _buildLiftList(snapshot, false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}
}
