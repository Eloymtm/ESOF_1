import 'package:flutter/material.dart';
import 'package:src/pages/login_page.dart';
import 'package:src/pages/register_page.dart';

class LogInOrRegisterPage extends StatefulWidget {
  const LogInOrRegisterPage({super.key});

  @override
  State<LogInOrRegisterPage> createState() => _LogInOrRegisterPageState();
}

class _LogInOrRegisterPageState extends State<LogInOrRegisterPage> {
  bool showLogInPage = true;

  void togglePages() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage();
    }
    ;
  }
}
