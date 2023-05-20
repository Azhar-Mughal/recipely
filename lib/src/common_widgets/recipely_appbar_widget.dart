import 'package:flutter/material.dart';
import 'package:recipely/src/common_widgets/common_widgets.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';
import '../utils/utils.dart';

class RecipelyAppBarWidget extends StatelessWidget implements PreferredSize {
  final String appBarText;
  final Color backgroundColor;

  const RecipelyAppBarWidget({
    Key? key,
    required this.appBarText,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: RecipelyTextWidget(
        text: appBarText,
        color: HexColor("#3a3b35"),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      leading: IconButton(
        onPressed: appBarText == loginText
            ? () {
                AppSnackBar.showSnackBar(
                    context: context, message: backButtonText);
              }
            : () {
                Navigator.pop(context);
              },
        icon: Icon(
          Icons.arrow_back,
          color: HexColor("#3a3b35"),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
