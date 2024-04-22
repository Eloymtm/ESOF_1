import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:src/components/my_drawer.dart';
import 'profile/button_widget.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location location = Location();

  static const LatLng _pGooglePlex = LatLng(37.816667, -25.533056);
  static const LatLng _dest = LatLng(37.81, -25.533056);

  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await fetchLocationUpdates());
  }

  final locationController = Location();

  void logout() {
    FirebaseAuth.instance.signOut();
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
    return Scaffold(
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
        markers: {
          const Marker(
              markerId: MarkerId('User'),
              position: _pGooglePlex,
              icon: BitmapDescriptor.defaultMarker),
          Marker(
              markerId: MarkerId('Destination'),
              position: _dest,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueYellow))
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

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    location.enableBackgroundMode(enable: true);

    locationController.onLocationChanged.listen((_locationData) {
      if (_locationData.latitude != null && _locationData.longitude != null) {
        setState(() {
          currentPosition =
              LatLng(_locationData.latitude!, _locationData.longitude!);
        });
        print(currentPosition);
      }
    });
  }
}
