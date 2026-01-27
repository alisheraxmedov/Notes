import 'package:flutter/material.dart';
import 'package:notes/core/const/colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final FontStyle fontStyle;
  final Color textColor;
  const TextWidget({
    super.key,
    required this.width,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.0,
    this.fontStyle = FontStyle.italic,
    this.textColor = ColorClass.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            fontFamily: "Courier",
            color: textColor,
          ),
    );
  }
}
