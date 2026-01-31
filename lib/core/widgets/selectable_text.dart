import 'package:flutter/material.dart';
import 'package:notes/core/const/colors.dart';

class SelectableTextWidget extends StatelessWidget {
  final String text;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign textAlign;

  const SelectableTextWidget({
    super.key,
    required this.width,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.textColor = ColorClass.black,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "Courier",
            color: textColor,
          ),
    );
  }
}
