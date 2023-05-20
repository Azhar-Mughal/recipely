import 'package:flutter/material.dart';

/// Common Text Widget With parameters for app level usage

class RecipelyTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const RecipelyTextWidget(
      {Key? key,
      required this.text,
      required this.color,
      required this.fontSize,
      required this.fontWeight,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
