import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/pages/profile/profile_page.dart';

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
          const DrawerHeader(
            child: Icon(
              FontAwesomeIcons.car,
              color: const Color.fromRGBO(246, 161, 86, 1),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromRGBO(246, 161, 86, 1),
            ),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/map_page');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list,
              color: const Color.fromRGBO(246, 161, 86, 1),
            ),
            title: Text("Lista"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/lift_page');
            },
          ),
          ListTile(
            leading: Icon(

              Icons.person,
              color: Color.fromRGBO(246, 161, 86, 1),
            ),
            title: Text("Profile"),
            onTap: () {
              // Profile Page
              Navigator.pop(context);
              Navigator.pushNamed(context, 'profile/profile_page');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color.fromRGBO(246, 161, 86, 1),
            ),
            title: const Text("Settings"),
            onTap: () {
              // Settings Page
            },
          ),
          Expanded(
            child: Container(), // Empty container to occupy remaining space
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
            onTap: () {
              logOut();
            },
          ),
        ],
      ),
    );
  }
}
