import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/src/common_widgets/common_widgets.dart';
import 'package:recipely/src/features/home/home.dart';

import '../../../constants/constants.dart';
import '../../../extensions/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    apiCalls();
    super.initState();
  }

  apiCalls() async {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.fetchRecipes();
    await homeProvider.fetchCategories();
    await homeProvider.fetchCuisines();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          backgroundColor: CupertinoColors.lightBackgroundGray,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Container(
                color: CupertinoColors.lightBackgroundGray,
                child: Column(
                  children: [
                    const RecipelyAppBarWidget(appBarText: searchText),
                    Container(
                      height: 90,
                      color: CupertinoColors.lightBackgroundGray,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                controller: provider.searchController,
                                textInputAction: TextInputAction.done,
                                cursorColor: HexColor("#00838f"),
                                cursorWidth: 0.5,
                                onFieldSubmitted: (value) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                onChanged: (value) {
                                  if (provider.searchController.text.isEmpty) {
                                    /// Hide Filters List Widget
                                    setState(() {
                                      provider.filterApplied = false;
                                    });
                                  } else {
                                    /// Clear Filtered List at first
                                    setState(() {
                                      provider.filteredFoodList.clear();
                                    });

                                    /// Apply search on recipe list from Firebase
                                    /// If any record matches then should be added in filtered list
                                    /// We can apply filters on multiple texts but here I am checking with name only
                                    for (var i = 0;
                                        i < provider.foodsList.length;
                                        i++) {
                                      if (provider.foodsList[i].name!
                                          .toLowerCase()
                                          .contains(provider
                                              .searchController.text
                                              .toLowerCase())) {
                                        setState(() {
                                          provider.filteredFoodList
                                              .add(provider.foodsList[i]);
                                        });
                                      }
                                    }

                                    /// Make filter applied variable true
                                    /// So user can be able to see filtered list data
                                    setState(() {
                                      provider.filterApplied = true;
                                    });
                                  }
                                },
                                style: TextStyle(
                                  color: HexColor("#3a3b35"),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color:
                                          HexColor("#3a3b35").withOpacity(0.3),
                                      width: 0.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: HexColor("#3a3b35"),
                                      width: 0.5,
                                    ),
                                  ),
                                  isDense: true,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: HexColor("#3a3b35"),
                                  ),
                                ),
                              ),
                            ),
                            gapW10,
                            FilterWidget(
                              filterOnPressed: () async {
                                await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter bottomSheetState) {
                                      return FractionallySizedBox(
                                        heightFactor: 0.55,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 22),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              gapH16,
                                              Container(
                                                width: 80,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: CupertinoColors
                                                      .lightBackgroundGray,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                              gapH16,
                                              const RecipelyTextWidget(
                                                text: filterText,
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              gapH28,
                                              Row(
                                                children: [
                                                  RecipelyTextWidget(
                                                    text: categoryText,
                                                    color: HexColor("#3a3b35"),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                              gapH4,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: provider
                                                    .categoriesList
                                                    .map(
                                                      (e) => CategoryWidget(
                                                        onPressed: () {
                                                          bottomSheetState(() {
                                                            e.selected =
                                                                !e.selected!;
                                                          });
                                                        },
                                                        text: e.name!,
                                                        isSelected: e.selected!,
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                              gapH28,
                                              Row(
                                                children: [
                                                  RecipelyTextWidget(
                                                    text: recipeTypeText,
                                                    color: HexColor("#3a3b35"),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                              gapH4,
                                              Wrap(
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                runAlignment:
                                                    WrapAlignment.spaceBetween,
                                                spacing: 12.0,
                                                children: provider.cuisineList
                                                    .map(
                                                      (e) => CategoryWidget(
                                                        onPressed: () {
                                                          bottomSheetState(() {
                                                            e.selected =
                                                                !e.selected!;
                                                          });
                                                        },
                                                        text: e.name!,
                                                        isSelected: e.selected!,
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                              gapH32,
                                              RecipelyButtonWidget(
                                                buttonText: applyFilterText,
                                                buttonBackgroundColor:
                                                    HexColor("#00838f"),
                                                onPressed: () {
                                                  List<Categories>
                                                      selectedCategories = [];
                                                  for (var i = 0;
                                                      i <
                                                          provider
                                                              .categoriesList
                                                              .length;
                                                      i++) {
                                                    if (provider
                                                        .categoriesList[i]
                                                        .selected!) {
                                                      selectedCategories.add(
                                                          provider
                                                              .categoriesList[i]);
                                                    }
                                                  }
                                                  List<Cuisine>
                                                      selectedCuisineList = [];
                                                  for (var i = 0;
                                                      i <
                                                          provider.cuisineList
                                                              .length;
                                                      i++) {
                                                    if (provider.cuisineList[i]
                                                        .selected!) {
                                                      selectedCuisineList.add(
                                                          provider
                                                              .cuisineList[i]);
                                                    }
                                                  }

                                                  bottomSheetState(() {
                                                    provider.filteredFoodList
                                                        .clear();
                                                  });
                                                  for (var i = 0;
                                                      i <
                                                          provider
                                                              .foodsList.length;
                                                      i++) {
                                                    for (var j = 0;
                                                        j <
                                                            selectedCategories
                                                                .length;
                                                        j++) {
                                                      if (selectedCategories[j]
                                                              .id ==
                                                          provider.foodsList[i]
                                                              .categoryId) {
                                                        bottomSheetState(() {
                                                          provider
                                                              .filteredFoodList
                                                              .add(provider
                                                                  .foodsList[i]);
                                                        });
                                                      }
                                                    }
                                                  }

                                                  for (var i = 0;
                                                      i <
                                                          provider
                                                              .foodsList.length;
                                                      i++) {
                                                    for (var j = 0;
                                                        j <
                                                            selectedCuisineList
                                                                .length;
                                                        j++) {
                                                      if (selectedCuisineList[j]
                                                              .id ==
                                                          provider.foodsList[i]
                                                              .cuisineId) {
                                                        bool foodAlreadyExists =
                                                            false;
                                                        bottomSheetState(() {});
                                                        for (var k = 0;
                                                            k <
                                                                provider
                                                                    .filteredFoodList
                                                                    .length;
                                                            k++) {
                                                          if (provider
                                                                  .filteredFoodList[
                                                                      k]
                                                                  .cuisineId ==
                                                              selectedCuisineList[
                                                                      j]
                                                                  .id) {
                                                            bottomSheetState(
                                                                () {
                                                              foodAlreadyExists =
                                                                  true;
                                                            });
                                                          }
                                                        }

                                                        if (foodAlreadyExists) {
                                                        } else {
                                                          bottomSheetState(() {
                                                            provider
                                                                .filteredFoodList
                                                                .add(provider
                                                                    .foodsList[i]);
                                                          });
                                                        }
                                                      }
                                                    }
                                                  }

                                                  bottomSheetState(() {
                                                    provider.filterApplied =
                                                        true;
                                                  });
                                                  Navigator.pop(context, true);
                                                },
                                              ),
                                              gapH8,
                                              RecipelyTextButtonWidget(
                                                buttonText: clearFilterText,
                                                buttonColor:
                                                    HexColor("#00838f"),
                                                onPressed: () {
                                                  for (var i = 0;
                                                      i <
                                                          provider
                                                              .categoriesList
                                                              .length;
                                                      i++) {
                                                    bottomSheetState(() {
                                                      provider.categoriesList[i]
                                                          .selected = false;
                                                    });
                                                  }
                                                  for (var i = 0;
                                                      i <
                                                          provider.cuisineList
                                                              .length;
                                                      i++) {
                                                    bottomSheetState(() {
                                                      provider.cuisineList[i]
                                                          .selected = false;
                                                    });
                                                  }
                                                  bottomSheetState(() {
                                                    provider.filterApplied =
                                                        false;
                                                  });
                                                  Navigator.pop(context, false);
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                );

                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          body: provider.showLoading
              ? const ShimmerEffectWidget()
              : ListView.builder(
                  itemCount: provider.filterApplied
                      ? provider.filteredFoodList.length
                      : provider.foodsList.length,
                  itemBuilder: (context, index) {
                    return ListWidget(
                      foodModel: provider.filterApplied
                          ? provider.filteredFoodList[index]
                          : provider.foodsList[index],
                    );
                  },
                ),
        );
      },
    );
  }
}
