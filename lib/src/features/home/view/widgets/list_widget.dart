import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipely/src/constants/constants.dart';
import 'package:recipely/src/extensions/extensions.dart';
import 'package:recipely/src/features/home/models/models.dart';

import '../../../../common_widgets/common_widgets.dart';

class ListWidget extends StatelessWidget {
  final Recipe foodModel;

  const ListWidget({
    Key? key,
    required this.foodModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      child: SizedBox(
        height: 130.0,
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      foodModel.image!,
                      fit: BoxFit.cover,
                      height: 130,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            color: HexColor("#00838f"),
                            backgroundColor:
                                CupertinoColors.extraLightBackgroundGray,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RecipelyTextWidget(
                        text: foodModel.name ?? "",
                        color: HexColor("#3a3b35"),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      gapH8,
                      RecipelyTextWidget(
                        text: foodModel.chef ?? "",
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: HexColor("#3a3b35"),
                  ),
                  height: 30,
                  width: 30,
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
