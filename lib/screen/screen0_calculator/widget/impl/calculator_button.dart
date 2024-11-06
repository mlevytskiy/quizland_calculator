import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  String text;
  Color color;
  Color textColor;
  bool isMagicMode;
  void Function(String context, BuildContext buildContext) onButtonClick;

  CalculatorButton(
      {required this.text,
      required this.color,
      required this.textColor,
      required this.isMagicMode,
      required this.onButtonClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: !isMagicMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            )
          : null,
      child: ElevatedButton(
        onPressed: () => onButtonClick(text, context),
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Background color
          elevation: 0, // Set elevation to 0 to delete default shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(75),
          ),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: isMagicMode ? 20 : 32,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
