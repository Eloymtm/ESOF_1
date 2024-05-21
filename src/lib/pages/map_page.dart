import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:src/pages/lift_page.dart';
import 'package:src/pages/mainPage.dart';
import 'package:src/pages/profile/profile_page.dart';

import 'package:geocoding/geocoding.dart';
import 'profile/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex = LatLng(41.14961, -8.61099);
  static const LatLng _dest = LatLng(41.14961, -8.61099);

  List<Marker> _markers = [];

  Future<LatLng?> getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];

        print(
            'Latitude: ${location.latitude}, Longitude: ${location.longitude}');
        return LatLng(location.latitude, location.longitude);
      } else {
        print('No location found for the address: $address');
        return null; // Retorno explícito caso nenhuma localização seja encontrada
      }
    } catch (e) {
      print('Error occurred: $e');
      return null; // Retorno explícito em caso de erro
    }
  }

  void navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LiftPage(),
        // Replace YourNextPage with the page you want to navigate to
      ),
    );
  }

  void _addMarkersForRides() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Ride').get();
    setState(() {
      _markers.clear(); // Clear existing markers
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> rideData = doc.data() as Map<String, dynamic>;
        String? partida = rideData['Partida'];
        String? destino = rideData['Destino'];
        if (destino != null) {
          getLocationFromAddress(destino).then((LatLng? start) {
            if (start != null) {
              // Faça algo com a localização obtida
              setState(() {
                _markers.add(
                  Marker(
                      markerId: MarkerId('ride_${_markers.length}'),
                      position: start,
                      onTap: () {
                        navigateToNextPage();
                      }
                      // Outros atributos do marcador
                      ),
                );
              });
            }
          }).catchError((error) {
            print('Erro ao obter a localização: $error');
          });
        }
      }
    });
  }

  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  //verificar se isto funciona
  Future createTrip(String Partida, String Destino, Timestamp time) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final String uid = currentUser.uid;

    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('User').doc(uid);

    await userDocRef.collection('Ride').add(
      {
        'Partida': Partida,
        'Destino': Destino,
        'HoraPartida': time,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> controllerGoogleMap = Completer();
    GoogleMapController mapController;

    void onCreated(GoogleMapController controller) {
      _addMarkersForRides();
      _controllerGoogleMap.complete(controller);

    }

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
                fontSize: 35),
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: GoogleMap(
        onMapCreated: onCreated,
        markers: _markers.map((e) => e).toSet(),
        compassEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: const CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
      ),
    );
  }
}
