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
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 40),
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            //Center(child: buildUpgradeButton()),
            NumbersWidget(),
          ],
      ),
    );
  }

 Widget buildName(User user) => Column(
   children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
     Text(user.email,
     style: TextStyle(color: Colors.grey),
     )
   ],
 );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
  );

}



