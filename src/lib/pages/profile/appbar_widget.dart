import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context){


  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
          icon: const Icon(Icons.dark_mode),
          onPressed: () {  },
      ),
    ],
    title: Text(
      "Profile",
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 35),
    ),
    centerTitle: true,
  );
}