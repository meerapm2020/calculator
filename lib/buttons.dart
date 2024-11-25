import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  const MyButtons(
      {super.key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
        //borderRadius: BorderRadius.circular(20),
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(color: textColor, fontSize: 20),
        )),
      ),
    ));
  }
}
