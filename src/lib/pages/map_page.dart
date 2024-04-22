import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:src/components/my_bot_bar.dart';
import 'package:src/components/my_drawer.dart';
import 'profile/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex = LatLng(37.816667, -25.533056);

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  //verificar se isto funciona 
 Future createTrip(String Partida, String Destino, Timestamp time) async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final String uid = currentUser.uid;

  
  DocumentReference userDocRef = FirebaseFirestore.instance.collection('User').doc(uid);

  await userDocRef.collection('Ride').add(
    {
      'Partida': Partida,
      'Destino': Destino,
      'HoraPartida': time,
    },
  );
}

  @override
  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Lift',
        onClicked: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/lift_page');
        },
      );

  @override
  Widget build(BuildContext context) {

    Completer<GoogleMapController> _controllerGoogleMap = Completer();
    GoogleMapController mapController;

    void onCreated(GoogleMapController controller) {
      _controllerGoogleMap.complete();
    }

    final Set<Marker> _markers = {};

    int _selectedIndex = 0;

    void navigateBottomBar(int index) {
      setState(() {
        _selectedIndex = index;
    });
  }

  //final List<> _pages = [LiftPage(), CreateLiftPage];

    return Scaffold(
      bottomNavigationBar: MyBotBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(),
          child: Text(
            "UNILIFT",
            style: TextStyle(
                color: Color.fromRGBO(246, 161, 86, 1),
                fontWeight: FontWeight.bold,
                fontSize: 35),
          ),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dark_mode)) // mudar logout para darkmode
        ],
      ),
      drawer: MyDrawer(context: context),
      body: GoogleMap(
        onMapCreated: onCreated,
        markers: {
          const Marker(
            markerId: MarkerId('User'),
            position: _pGooglePlex,
            icon: BitmapDescriptor.defaultMarker
          )
        },
        compassEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: const CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
      ),
      floatingActionButton: buildUpgradeButton(),
    );
  }
}
