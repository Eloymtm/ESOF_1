import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context){


  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const Text(
      "Perfil",
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 35),
    ),
    centerTitle: true,
  );
}