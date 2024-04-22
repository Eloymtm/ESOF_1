import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool showIcon;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.showIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(246, 161, 86, 1);

    return Center(
      child: Stack(
        children: [
          buildImage(),
           if (showIcon) Positioned(
            bottom: 0,
            right: 4,
            child: buidEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(onTap: onClicked),
          ),
        )
    );
  }

  Widget buidEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color:color,
      all: 8,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );


  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
    ClipOval(
        child:  Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        )
    );

}
