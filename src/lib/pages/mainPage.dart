import 'package:flutter/material.dart';
import 'package:src/components/my_bot_bar.dart';
import 'package:src/pages/create_lift_page.dart';
import 'package:src/pages/lift_page.dart';
import 'package:src/pages/map_page.dart';
import 'package:src/pages/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _tempPageState();
}

int selectedIndex=0;
class _tempPageState extends State<MainPage> {
   
  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const MapPage(),
    const CreateLiftPage(),
    const LiftPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBotBar(onTabChange: (index) => navigateBottomBar(index)),
      body:_pages[selectedIndex]
    );
  }
}