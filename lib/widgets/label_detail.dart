import 'package:flutter/material.dart';

class LabelDetail extends StatelessWidget {
  final String label;
  final String value;
  const LabelDetail({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
      children: [
        // Text(label + ': ', style: Theme.of(context).textTheme.headlineSmall),
        Text(label + ': ',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.grey[400])),
        Text(value,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.grey[800]))
      ],
    ));
  }
}
