import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:src/pages/profile/appbar_widget.dart';
import 'package:src/pages/profile/profile_widget.dart';
import 'package:src/pages/profile/user.dart';
import 'package:src/pages/profile/user_preferences.dart';

import 'button_widget.dart';
import 'numbers_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
    final user = UserPreferences.myUser;

    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 40),
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              buildName(currentUser),
              const SizedBox(height: 24),
              NumbersWidget(),
              const SizedBox(height: 24),
              buildUpgradeButton(),
              ///MENU
              const Divider(endIndent: 50, indent: 50),
              const SizedBox(height: 10),

              profile_widget(title: "Settings", icon: Icons.settings, onPress: (){},),
              profile_widget(title: "Historic", icon: Icons.history, onPress: (){}),
              const Divider(endIndent: 50, indent: 50),
              profile_widget(title: "Logout", icon: Icons.logout, onPress: logOut, endIcon: false, textColor: Colors.red),
            ],
        ),

    );
  }

 Widget buildName(currentUser) => Column(
   children: [
      Text(
        //user.name,
        "Martim Manhã",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      ),
     Text(
       //user.email,
       currentUser.email,
     style: const TextStyle(color: Colors.grey, fontSize: 17),
     )
   ],
 );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit Profile',
        onClicked: () {},
  );


  void editProfile() {
    print("merda pra ti");
  }
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
            child: Icon(icon, color: Color.fromRGBO(246, 161, 86, 1), size: 24,),
          ),
        title: Text(title , style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400)?.apply(color: textColor)),
        trailing: endIcon? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Icon(Icons.chevron_right),
        ) : null,
      ),
    );
  }
}



