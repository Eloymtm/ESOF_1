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
    padding: const EdgeInsets.symmetric(horizontal: 130.0),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, shape: StadiumBorder(),
          backgroundColor: Colors.orange,
        ),
        child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        onPressed: onClicked,

    ),
  );
}
