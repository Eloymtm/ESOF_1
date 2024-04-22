import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/pages/profile/profile_widget.dart';

class EditProfileScreen extends StatelessWidget {

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: BackButton(),
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
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: const Text('Name'),
                                    prefix: const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(FontAwesomeIcons.user),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 2.0, color: Color.fromRGBO(246, 161, 86, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  ),
                                  cursorColor: const Color.fromRGBO(246, 161, 86, 1),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  decoration: InputDecoration(
                                      label: const Text('Email'),
                                      prefix: const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(FontAwesomeIcons.envelope),
                                      ),
                                      focusedBorder:  OutlineInputBorder(
                                          borderSide: const BorderSide(width: 2.0, color: Color.fromRGBO(246, 161, 86, 1),
                                          ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  ),
                                  cursorColor: const Color.fromRGBO(246, 161, 86, 1),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: const Text('Password'),
                                    prefix: const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(FontAwesomeIcons.fingerprint),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 2.0, color: Color.fromRGBO(246, 161, 86, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  ),
                                  cursorColor: const Color.fromRGBO(246, 161, 86, 1),
                                ),
                                const SizedBox(height: 30),
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
      ));
  }
}
