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
    title: Container(
      height: 100,
      child: Image(
        image: AssetImage('lib/images/logo.jpg'),
      ),
    ),
    centerTitle: true,
  );
}