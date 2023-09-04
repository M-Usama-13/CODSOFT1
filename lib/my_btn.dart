import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {

  final String text;
  final Color textColor;
  final Color color;
  final VoidCallback btnTapped;

  const MyBtn({Key? key, required this.text, required this.textColor, required this.color, required this.btnTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnTapped,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                  color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
            ),
              ),
        ),
          ),
      ),
    );
  }
}
