import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:user_module/control/home_control/service/home_service.dart';
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

  // set setselectedIndex(dynamic value) {
  //   _selectedIndex = value;
  //   notifyListeners();
  // }

  void selectCategory(CategoryModel categoryId) {
    _categoryName = categoryId.name;
    _categoryId = categoryId.id;
    log('selected category name : $_categoryName');
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _categories = await homeService.getAllCategory();
    notifyListeners();
  }
}
