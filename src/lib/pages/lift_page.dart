import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/components/my_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



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
        actions: [
          IconButton(
            onPressed: () {
              // Função de alternância de modo escuro
              print('Modo escuro ativado');
            },
            icon: const Icon(Icons.dark_mode),
          )
        ],
      ),
      drawer: const MyDrawer(),
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
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 20, // Número de itens na lista
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                  onTap: () {
                    print('Item $index selecionado');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}