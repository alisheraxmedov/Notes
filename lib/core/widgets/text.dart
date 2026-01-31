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
  final TextAlign textAlign;
  const TextWidget({
    super.key,
    required this.width,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.0,
    this.fontStyle = FontStyle.italic,
    this.textColor = ColorClass.black,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
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
