import 'package:flutter/material.dart';
import 'package:recipely/src/common_widgets/common_widgets.dart';

/// Common Text Button Widget With parameters for app level usage

class RecipelyTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function()? onPressed;

  const RecipelyTextButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: RecipelyTextWidget(
        text: buttonText,
        color: buttonColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
