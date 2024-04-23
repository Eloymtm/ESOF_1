import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBotBar extends StatelessWidget {
  void Function(int)? onTabChange;

  MyBotBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 227, 222, 222),
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GNav(
        //color: Colors.orange,
        activeColor: Colors.black,
        //tabActiveBorder: Border.all(color: Colors.transparent),
        tabBackgroundColor: Color.fromRGBO(246, 161, 86, 1),
        tabMargin: EdgeInsets.symmetric(horizontal: 10),
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 20,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            iconColor: Colors.black,
          ),
          GButton(
            icon: Icons.add,
            iconColor: Colors.black,
          ),
          GButton(
            icon: FontAwesomeIcons.eye,
            iconColor: Colors.black,
          ),
          GButton(
            icon: FontAwesomeIcons.user,
          )
        ],
      ),
    );
  }
}
