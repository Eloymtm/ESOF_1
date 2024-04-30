import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context){


  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
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