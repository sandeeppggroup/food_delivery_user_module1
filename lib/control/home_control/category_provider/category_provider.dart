import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_module/control/home_control/service/home_service.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/home_model/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  HomeService homeService = HomeService();

  List<CategoryModel> _categories = [];
  dynamic _categoryName;
  String? _categoryId;
  // dynamic _selectedIndex;

  List<CategoryModel> get categories => _categories;

  dynamic get categoryName => _categoryName;

  String? get categoryId => _categoryId;

  // dynamic get selectedIndex => _selectedIndex;

  CategoryProvider() {
    fetchCategories();
  }

  set setCategoryName(dynamic value) {
    _categoryName = value;
    notifyListeners();
  }

  void selectCategory(CategoryModel categoryId) {
    _categoryName = categoryId.name;
    _categoryId = categoryId.id;
    log('selected category name : $_categoryName');
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    final result = await homeService.getAllCategory();

    if (result != null) {
      _categories = result;
    } else {
      Fluttertoast.showToast(
          msg: 'Oops! Something went wrong. Please try again',
          fontSize: 16,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: buttonColor);
      _categories = [];
      notifyListeners();
      return;
    }
    notifyListeners();
  }
}
