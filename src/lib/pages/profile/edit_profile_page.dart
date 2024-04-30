import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/helper/globalVariables.dart';
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

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser.uid)
          .get();

      if (userDataSnapshot.exists) {
        final userData = userDataSnapshot.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = userData['Name'] ?? '';
          emailController.text = userData['Email'] ?? '';
        });
      } else {
        // Caso o documento do usuário não exista no Firestore
        // Você pode tratar isso aqui, por exemplo, redirecionando o usuário para a tela de login
      }
    } catch (e) {
      // Lidar com erros, como falta de conexão com a internet
      print('Error getting user data: $e');
    }
  }



  Future<void> updateUserInformation(String newValue, bool isName) async {
    try {
      if (isName){
        //await currentUser.updateDisplayName(newValue);
        await FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .update({'Name': newValue});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Name updated successfully!'),
          duration: Duration(seconds: 2),
        ));
      } else {
        //await currentUser.verifyBeforeUpdateEmail('pedrodsspedro@gmail.com');
        //await currentUser.sendEmailVerification();
        await FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .update({'Email': newValue});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email updated successfully!'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to update. Please try again later.'),
        duration: Duration(seconds: 2),
      ));
    }
  }


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
                                const SizedBox(height: 15),
                                EditableNameField(
                                  labelText: 'Name',
                                  initialValue: userData['Name'], // Valor inicial do campo
                                  onEditPressed: () {
                                    String newName = nameController.text.trim();
                                    if (newName.isNotEmpty ) {
                                      updateUserInformation(newName, true);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text('Please enter a valid email.'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  },
                                  prefIcon: FontAwesomeIcons.user,
                                  bottonText: 'Edit Name',
                                  controller: nameController,
                                ),

                                const SizedBox(height: 30),
                                EditableNameField(
                                  labelText: 'Email',
                                  initialValue: userData['Email'], // Valor inicial do campo
                                  onEditPressed: () {
                                    String newEmail = emailController.text.trim();
                                    if (newEmail.isNotEmpty && EmailValidator.validate(newEmail)) {
                                      updateUserInformation(newEmail, false);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text('Please enter a valid email.'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  },
                                  prefIcon: FontAwesomeIcons.envelope,
                                  bottonText: 'Edit Email',
                                  controller: emailController,
                                ),

                                const Divider(height: 80, thickness: 5, color: primaryColor,),

                                EditableNameField(
                                  labelText: 'Old Pass',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: true,
                                  controller: oldPasswordController,
                                ),

                                const SizedBox(height: 30),

                                EditableNameField(
                                  labelText: 'New Pass',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: true,
                                  controller: newPasswordController,
                                ),

                                const SizedBox(height: 30),

                                EditableNameField(
                                  labelText: 'Confirm New Pass',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: true,
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
