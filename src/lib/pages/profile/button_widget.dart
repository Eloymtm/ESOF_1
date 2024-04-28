import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final double padH;
  final double padV;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.padH = 110,
    this.padV = 20,
}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, shape: const StadiumBorder(),
          backgroundColor: Colors.orange,
          minimumSize: Size(double.infinity, 45),
        ),
        onPressed: onClicked,
        child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

    ),
  );
}
