import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/main.dart';
import 'package:src/pages/login_page.dart';
import 'package:src/pages/map_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MapPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
