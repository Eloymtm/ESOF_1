import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 110.0, vertical: 20),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, shape: const StadiumBorder(),
          backgroundColor: Colors.orange,
          minimumSize: Size(double.infinity, 55),
        ),
        onPressed: onClicked,
        child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),

    ),
  );
}
