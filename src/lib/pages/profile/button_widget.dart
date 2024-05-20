import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final double padH;
  final double padV;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onClicked,
    this.padH = 110,
    this.padV = 20,
});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, shape: const StadiumBorder(),
          backgroundColor: const Color.fromRGBO(246, 161, 86, 1),
          minimumSize: const Size(double.infinity, 45),
        ),
        onPressed: onClicked,
        child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

    ),
  );
}
