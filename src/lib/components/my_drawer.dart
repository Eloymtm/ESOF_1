import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:src/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.car_rental_rounded,
              color: const Color.fromRGBO(246, 161, 86, 1),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: const Color.fromRGBO(246, 161, 86, 1),
            ),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/map_page');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: const Color.fromRGBO(246, 161, 86, 1),
            ),
            title: Text("Profile"),
            onTap: () {
              //Profile Page
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile_page');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: const Color.fromRGBO(246, 161, 86, 1),
            ),
            title: Text("Settings"),
            onTap: () {
              //n sei se vai existir mas caso exista -> Settings Page
            },
          ),
          const SizedBox(
            height: 350,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () {
              logOut();
            },
          )
        ],
      ),
    );
  }
}
