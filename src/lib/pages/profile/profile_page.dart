import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/pages/map_page.dart';
import 'package:src/pages/profile/appbar_widget.dart';
import 'package:src/pages/profile/edit_profile_page.dart';
import 'package:src/pages/profile/get_username.dart';
import 'package:src/pages/profile/profile_widget.dart';

import 'button_widget.dart';
import 'numbers_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;


  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context); // Fechar o drawer
      Navigator.pushNamedAndRemoveUntil(context, '/login_page', (route) => false); // Redirecionar para a tela de login e remover todas as rotas anteriores
    } catch (e) {
      print("Erro ao fazer logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
      buildAppBar(context),
      body:StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('User').doc(currentUser.uid).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  ProfileWidget(
                    imagePath: userData['ImagePath'],
                    onClicked: () async {},
                    showIcon: false,
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      Text(
                        userData['Name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Text(
                        userData['Email'],
                        style: const TextStyle(color: Colors.grey, fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  NumbersWidget(rating: (userData['Rating'])),
                  const SizedBox(height: 24),
                  buildEditButton(),
                  ///MENU
                  const Divider(endIndent: 50, indent: 50),
                  const SizedBox(height: 10),

                  profile_widget(title: "Definições", icon: Icons.settings, onPress: (){}),
                  profile_widget(title: "Meus carros", icon: CupertinoIcons.car, onPress: () { Navigator.pushNamed(context, '/my_cars_page');}),
                  profile_widget(title: "Histórico", icon: Icons.history, onPress: (){}),
                  const Divider(endIndent: 50, indent: 50),
                  profile_widget(title: "Logout", icon: Icons.logout, onPress: logOut, endIcon: false, textColor: Colors.red),
                ],
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

  Widget buildEditButton() => ButtonWidget(
        text: 'Editar perfil',
        onClicked: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfileScreen()),
          );
        },
  );
}

class profile_widget extends StatelessWidget {
  const profile_widget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.orange.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
        ),
        title: Text(title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400)
                ?.apply(color: textColor)),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Icon(Icons.chevron_right),
              )
            : null,
      ),
    );
  }
}
