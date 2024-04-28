import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/pages/profile/profile_widget.dart';

import 'button_widget.dart';
import 'edit_field_widget.dart';



class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfileScreen> {

  final currentUser = FirebaseAuth.instance.currentUser!;


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  /*Future signUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        print(nameController.text);
        print(emailController.text);
        addUserDetails(nameController.text, emailController.text);
        Navigator.pushNamed(context, '/main_page');
      } else {
        showErrorMessage("Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
  }

  Future addUserDetails(String name, String email) async{
    final currentUser = FirebaseAuth.instance.currentUser!;
    final String uid = currentUser.uid;
    await FirebaseFirestore.instance.collection('User').doc(uid).set(
        {
          'Name' : name,
          'Email' : email,
          'ImagePath' : 'https://publicdomainvectors.org/tn_img/abstract-user-flat-4.webp',
          'Rating' : "0.0",
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: const BackButton(),
        title: Text("Edit Profile", style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('User').doc(currentUser.uid).snapshots(),
    builder: (context, snapshot) {
          if (snapshot.hasData){
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        ProfileWidget(
                          imagePath: userData['ImagePath'],
                          onClicked: () async {},
                          showIcon: true,
                        ),
                        const SizedBox(height: 20),
                        Form(
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                Text(userData['Name'], style: TextStyle(fontSize: 20),),
                                EditableNameField(
                                  labelText: 'Name',
                                  //initialValue: userData['Name'], // Valor inicial do campo
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.user,
                                  bottonText: 'Edit Name',
                                  controller: nameController,
                                ),

                                const SizedBox(height: 30),
                                Text(userData['Email'], style: TextStyle(fontSize: 20),),
                                EditableNameField(
                                  labelText: 'Email',
                                  //initialValue: userData['Email'], // Valor inicial do campo
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.envelope,
                                  bottonText: 'Edit Email',
                                  controller: emailController,
                                ),

                                const Divider(height: 80, thickness: 5, color: Colors.orange,),

                                EditableNameField(
                                  labelText: 'Old Pass',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: false,
                                  controller: oldPasswordController,
                                ),

                                const SizedBox(height: 30),

                                EditableNameField(
                                  labelText: 'New Pass',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: false,
                                  controller: newPasswordController,
                                ),

                                const SizedBox(height: 30),

                                EditableNameField(
                                  labelText: 'Confirm New Pass',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: false,
                                  controller: confirmPasswordController,
                                ),

                                const SizedBox(height: 10),
                                ButtonWidget(
                                  text: 'Change',
                                  onClicked: () {},
                                  padH: 60,
                                ),
                              ],
                            ),
                        )
                      ],
                    ),
                  ),

              );
          }
          else if(snapshot.hasError){
              return Center(child: Text('Error${snapshot.error}'),);
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }

    },

      ),
    );
  }



}
