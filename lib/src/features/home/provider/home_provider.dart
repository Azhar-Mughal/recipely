import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:recipely/src/constants/constants.dart';

import '../home.dart';

class HomeProvider extends ChangeNotifier {
  bool showLoading = true;
  bool filterApplied = false;
  List<Recipe> foodsList = [];
  List<Recipe> filteredFoodList = [];

  TextEditingController searchController = TextEditingController();

  fetchRecipes() async {
    try {
      FirebaseFirestore.instance
          .collection(food)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final responseData = data[list] as List<dynamic>;

          foodsList = responseData.map((e) => Recipe.fromJson(e)).toList();

          showLoading = false;
          notifyListeners();
        }
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      showLoading = false;
      notifyListeners();
    }
  }

  List<Categories> categoriesList = [];

  fetchCategories() async {
    try {
      FirebaseFirestore.instance
          .collection(categories)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final responseData = data[list] as List<dynamic>;

          categoriesList =
              responseData.map((e) => Categories.fromJson(e)).toList();
        }
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    }
  }

  List<Cuisine> cuisineList = [];

  fetchCuisines() async {
    try {
      FirebaseFirestore.instance
          .collection(cuisine)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final responseData = data[list] as List<dynamic>;

          cuisineList = responseData.map((e) => Cuisine.fromJson(e)).toList();
        }
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    }
  }
}
