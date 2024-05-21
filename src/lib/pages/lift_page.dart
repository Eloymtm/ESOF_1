import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:src/components/lift_card.dart';
import 'package:src/helper/helper_method.dart';
import 'package:src/pages/map_page.dart';
import 'package:src/pages/profile/chat/chat_page10.dart';
import 'package:src/pages/trip_details.dart';




class LiftPage extends StatefulWidget {

    const LiftPage({super.key});

  @override
  State<LiftPage> createState() => LiftPageState();
}
class LiftPageState extends State<LiftPage> {

  void logout() {
    FirebaseAuth.instance.signOut();
  }

   @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
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
      elevation: 2,
      
    ),
    body: Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Ride').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.docs.length, // Número de itens na lista
                  itemBuilder: (BuildContext context, int index) {
                    final ride = snapshot.data!.docs[index];
                    final partida = ride['Partida'];
                    final destino = ride['Destino'];
                    final horaPartida = formatData(ride['HoraPartida']);
                    final referenciaCondutor = ride['Driver'];
                    final numPassageiros = ride['passageiros'].length;

                     return FutureBuilder<DocumentSnapshot>(
                     future: referenciaCondutor.get(),
                     builder: (context, driverSnapshot) {
                         if (!driverSnapshot.hasData) {
                           return const Center(child: CircularProgressIndicator());
                         }
                         final driverData = driverSnapshot.data!;
                         final nomeCondutor = driverData['Name'];

                       return GestureDetector(
                           child: Lift_card(destino: destino,
                         partida: partida,
                         horaPartida: horaPartida,
                         condutor: nomeCondutor,
                         NumPassageiros: numPassageiros,
                         onTap:() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TripDetailsPage(
                                      refRide: ride,
                                    ),
                                  ),
                                )
                           )
                       );
                     });
                  },
                );
              }
              else if(snapshot.hasError){
                return Center(child: Text('Error${snapshot.error}'),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    ),
  );
}

}