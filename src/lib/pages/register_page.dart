import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  Future signUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        print(nameController.text);
        print(emailController.text);
        addUserDetails(nameController.text, emailController.text);
        Navigator.pushNamed(context, '/main_page');
      } else {
        showErrorMessage("As palavras-passe não correspondem");
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
    //Navigator.pop(context);
    //MapPage();
  }

 Future addUserDetails(String name, String email) async{
   final currentUser = FirebaseAuth.instance.currentUser!;
   final String uid = currentUser.uid;
    await FirebaseFirestore.instance.collection('User').doc(uid).set(
        {
          'Name' : name,
          'Email' : email,
          'ImagePath' : 'https://publicdomainvectors.org/tn_img/abstract-user-flat-4.webp',
          'SumRatings' : 1,
          'TotalRatings' : 1,
        } 
    );
 }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.orange,
              title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ));
        });
  }

  /*void createaccount() {
    RegisterPage();
  }*/

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
                          color: Color.fromRGBO(246, 161, 86, 1),
                          fontSize: 50,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  TextField(
                    key: const Key("emailField"),
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Insere email de estudante..",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    key: const Key("nameField"),
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Insere o seu nome...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    key: const Key("passwordField"),
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Insere uma palavra-passe...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    key: const Key("confirmPasswordField"),
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Confirmar palavra-passe...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login_page');
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text("Já tem conta?",
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  MaterialButton(
                    onPressed: signUp,
                    height: 50,
                    minWidth: 200,
                    color: const Color.fromRGBO(246, 161, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text("Sign up",
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
  }
}
