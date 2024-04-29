import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:src/components/lift_card.dart';
import 'package:src/helper/helper_method.dart';




class LiftPage extends StatefulWidget {

    const LiftPage({super.key});

  @override
  State<LiftPage> createState() => LiftPageState();
}
class LiftPageState extends State<LiftPage> {
  final LatLng _pGooglePlex = const LatLng(37.422, -122.084);

  void logout() {
    FirebaseAuth.instance.signOut();
  }

   @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
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
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pGooglePlex,
              zoom: 13,
            ),
          ),
        ),
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
                    //final nomeCondutor = ride['Driver'];
                    
                    return Lift_card(destino: destino, partida: partida, horaPartida: horaPartida);
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