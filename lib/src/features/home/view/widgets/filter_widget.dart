import 'package:flutter/material.dart';

import '../../../../extensions/extensions.dart';

class FilterWidget extends StatelessWidget {
  final Function()? filterOnPressed;

  const FilterWidget({
    Key? key,
    required this.filterOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: filterOnPressed,
      color: HexColor("#00838f"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          HexColor("#00838f"),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(50, 50),
        ),
      ),
      icon: const Icon(
        Icons.filter_alt,
        color: Colors.white,
      ),
    );
  }
}
