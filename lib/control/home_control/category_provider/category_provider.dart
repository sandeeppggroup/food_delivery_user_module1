import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:user_module/control/home_control/service/home_service.dart';
import 'package:user_module/model/home_model/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  HomeService homeService = HomeService();

  List<CategoryModel> _categories = [];
  String? _categoryName = '';

  String? get categoryName => _categoryName;

  List<CategoryModel> get categories => _categories;

  CategoryProvider() {
    fetchCategories();
  }

  void selectCategory(CategoryModel categoryId) {
    _categoryName = categoryId.name;
    log('selected category name : $_categoryName');
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _categories = await homeService.getAllCategory();
    notifyListeners();
  }
}
