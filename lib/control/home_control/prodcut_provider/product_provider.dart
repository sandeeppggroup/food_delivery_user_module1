import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/service/home_service.dart';
import 'package:user_module/model/home_model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  HomeService homeService = HomeService();
  CategoryProvider categoryProvider = CategoryProvider();

  List<ProductModel> _productList = [];

  ProductProvider() {
    fetchAllProducts();
  }

  List<ProductModel> get productlist => _productList;

  Future<void> fetchCategoryWiseProduct(String categoryId) async {
    log('in fetchCategoryWiseProduct : $categoryId');

    _productList.clear();

    _productList = await homeService.getCategoryWiseProduct(categoryId);

    notifyListeners();
  }

  Future<void> fetchAllProducts() async {
    _productList = await homeService.getAllProduct();
    notifyListeners();
  }
}
