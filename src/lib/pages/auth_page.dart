import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/pages/login_or_register_page.dart';
import 'package:src/pages/mainPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const LogInOrRegisterPage();
          }
        },
      ),
    );
  }
}
