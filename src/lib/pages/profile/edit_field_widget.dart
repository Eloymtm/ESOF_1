import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/helper/globalVariables.dart';

class EditableNameField extends StatelessWidget {
  final String ?labelText;
  final String? initialValue;
  final VoidCallback ?onEditPressed;
  final IconData ?prefIcon;
  final String ?bottonText;
  final bool showSuffixButton;
  final IconData ?sufixIcon;
  final bool watch;
  final String ?initialV;
  final TextEditingController ?controller;

  const EditableNameField({
    Key? key,
    this.labelText,
    this.initialValue,
    this.onEditPressed,
    this.prefIcon,
    this.bottonText,
    this.showSuffixButton = true,
    this.sufixIcon,
    this.watch = false,
    required this.controller,
    this.initialV,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialV,
      obscureText: watch,
      //initialValue: initialValue ?? '',
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        labelText: labelText,
        prefix: Padding(
          padding: EdgeInsets.only(right: 10, bottom: 5),
          child: Icon(prefIcon),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        suffix: showSuffixButton ?
        GestureDetector(
          onTap: onEditPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              bottonText ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ) : GestureDetector(
          onTap: onEditPressed, // Adicione a lógica de quando o ícone é pressionado
          child: Icon(
            sufixIcon,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
      cursorColor: primaryColor,
    );
  }
}