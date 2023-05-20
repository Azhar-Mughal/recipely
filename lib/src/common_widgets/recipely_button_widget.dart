import 'package:flutter/material.dart';
import 'package:recipely/src/common_widgets/common_widgets.dart';

/// Common Button Widget With parameters for app level usage

class RecipelyButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonBackgroundColor;
  final Function()? onPressed;

  const RecipelyButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonBackgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          buttonBackgroundColor,
        ),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.of(context).size.width, 56),
        ),
        overlayColor: MaterialStateProperty.all(
          Colors.white,
        ),
      ),
      child: RecipelyTextWidget(
        text: buttonText,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
