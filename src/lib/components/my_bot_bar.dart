import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBotBar extends StatelessWidget {
    void Function(int)? onTabChange;

    MyBotBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: GNav(
            color: Colors.orange,
            activeColor: Colors.orange[500],
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: Colors.orange.shade100,
            mainAxisAlignment: MainAxisAlignment.center,
            tabBorderRadius: 20,
            onTabChange: (value) => onTabChange!(value),
            tabs: const [
                GButton(icon: Icons.abc, text: "Create Lift",),
                GButton(icon: Icons.abc, text: "View Lifts",),
            ],
        ),
    );
  }
}