import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/common_widgets.dart';
import '../../../../extensions/extensions.dart';

class CategoryWidget extends StatelessWidget {
  final String text;
  final bool isSelected;

  final Function()? onPressed;

  const CategoryWidget({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isSelected
              ? HexColor("#00838f")
              : CupertinoColors.lightBackgroundGray,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RecipelyTextWidget(
          text: text,
          color: isSelected ? Colors.white : HexColor("#3a3b35"),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
