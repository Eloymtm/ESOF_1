import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/helper/globalVariables.dart';

import 'chat/chat_page10.dart';

class MyLiftsPage extends StatefulWidget {
  const MyLiftsPage({super.key});

  @override
  State<MyLiftsPage> createState() => _MyLiftsPageState();
}

class _MyLiftsPageState extends State<MyLiftsPage> {
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
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: FutureBuilder<DocumentSnapshot>(
        future: referenciaCondutor.get(),
        builder: (context, driverSnapshot) {
          if (!driverSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final CarData = driverSnapshot.data!;
          final marcaRide = CarData['marca'];

          return ListTile(
            title: Text(doc['Destino'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Partida: ${doc['Partida']}'),
                Text('Hora: ${liftTime.toLocal()}'),
                Text('Carro: ${marcaRide}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(isDriver ? Icons.cancel : Icons.exit_to_app, color: Colors.red),
              onPressed: () {
                if (isDriver) {
                  _cancelLift(doc.id);
                } else {
                  _leaveLift(doc.id);
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chatId: doc.id),
                ),
              );
            },
          );
        },
      ),
    );
  }


  Widget _buildLiftList(AsyncSnapshot<QuerySnapshot> snapshot, bool como) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    final lifts = snapshot.data!.docs.where((doc) {
      final liftTime = doc['HoraPartida'] as Timestamp;
      return _isUpcomingOrRecent(liftTime);
    }).toList();

    if (lifts.isEmpty) {
      return Center(child: Text('Não tens nenhuma viagem.'));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Viagens'),
        titleTextStyle: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 25),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Como Condutor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Como Passageiro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          ),
        ],
      ),
    );
  }
}
