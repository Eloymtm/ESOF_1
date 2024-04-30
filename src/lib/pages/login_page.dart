import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/pages/map_page.dart';
import 'package:src/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
          Navigator.pushNamed(context, '/main_page');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Email não encontrado");
      } else if (e.code == 'wrong-password') {
        print("Palavra-passe incorreta");
      }
    }
  }

  void createaccount() {
    //RegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.all(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("UNILIFT",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Insere o email de estudante...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Insere a palavra-passe...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/register_page');
                          },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Criar conta",
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 130),
                        child: Align(
                          child: Text(
                            "Esqueceu a password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  MaterialButton(
                    onPressed: signIn,
                    height: 50,
                    minWidth: 150,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
