import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:src/components/my_drawer.dart';
import 'profile/button_widget.dart';

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
              onPressed: (){},
              icon: const Icon(Icons.dark_mode)) // mudar logout para darkmode
        ],
      ),
      drawer: const MyDrawer(),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
      ),
      floatingActionButton: buildUpgradeButton(),
    );
  }
}
