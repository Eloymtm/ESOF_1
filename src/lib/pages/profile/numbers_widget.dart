import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({
    Key? key,
    required this.rating,
}) : super(key: key);

  final double rating;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    <Widget>[
      buildButton(context, rating, ''),
    ],
  );

  Widget buildButton(BuildContext context, double value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              value.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(width: 10),
            const Icon(
              FontAwesomeIcons.solidStar,
              color: Colors.amber,
              size: 35,
            ),
          ],
        ),
      );
}
