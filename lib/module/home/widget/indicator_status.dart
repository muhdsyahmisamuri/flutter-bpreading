import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final String label;
  final Color color;

  const IndicatorWidget({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: color,
          radius: 8.0,
        ),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
