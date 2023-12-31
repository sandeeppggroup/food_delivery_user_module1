// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/service/home_service.dart';
import 'package:user_module/control/product_view_control/provider/product_view_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/home_model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  HomeService homeService = HomeService();
  CategoryProvider categoryProvider = CategoryProvider();
  ProductViewProvider productViewProvider = ProductViewProvider();
  CartProvider cartProvider = CartProvider();
  String? customerName;

  List<ProductModel> _productList = [];

  ProductProvider() {
    fetchAllProducts();
  }

  Future<void> getCustomerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerName = prefs.getString('customerName');
  }

  List<ProductModel> get productlist => _productList;

  Future<void> fetchCategoryWiseProduct(
      String categoryId, String categoryName) async {
    log('in fetchCategoryWiseProduct : $categoryId');
    _productList.clear();
    dynamic result = await homeService.getCategoryWiseProduct(categoryId);
    if (result != null) {
      _productList = result;
    } else {
      Fluttertoast.showToast(
        msg:
            'Oops! Something went wrong.  \nplease check your network connection',
        backgroundColor: buttonColor,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 15,
      );
      _productList = [];
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  Future<void> fetchSortCategoryAndPriceWiseProduct(
      {String categoryId = '',
      String sorturl = '',
      String searchUrl = ''}) async {
    log('in fetch sort category and price wise product : $categoryId,   $sorturl');
    _productList.clear();
    if (searchUrl != '') {
      log('Sorturl in ProductProvider : $searchUrl');
      _productList.clear();
      _productList = await homeService.getCategoryWiseProductHighToLow(
          searchUrl: searchUrl);
      notifyListeners();
      return;
    }
    if (categoryId.isEmpty) {
      _productList =
          await homeService.getCategoryWiseProductHighToLow(sortUrl: sorturl);
    } else {
      _productList = await homeService.getCategoryWiseProductHighToLow(
          categoryIdUrl: categoryId, sortUrl: sorturl);
    }
    notifyListeners();
  }

  Future<void> fetchAllProducts() async {
    final result = await homeService.getAllProduct();
    if (result != null) {
      _productList = result;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg:
            'Oops! Something went wrong.  \nplease check your network connection',
        backgroundColor: buttonColor,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 15,
      );
      _productList = [];
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  void sortProductLowToHigh() async {
    dynamic categoryName = categoryProvider.categoryName;
    String urlLowToHigh = 'lowToHigh';
    String? categoryId = categoryProvider.categoryId;
    if (categoryName != null) {
      fetchSortCategoryAndPriceWiseProduct(
          categoryId: categoryId!, sorturl: urlLowToHigh);
    } else {
      fetchSortCategoryAndPriceWiseProduct(sorturl: urlLowToHigh);
    }
  }

  void sortProductHighToLow() async {
    dynamic categoryName = categoryProvider.categoryName;
    String urlHighToLow = 'highToLow';
    String? categoryid = categoryProvider.categoryId;

    if (categoryName != null) {
      fetchSortCategoryAndPriceWiseProduct(
          categoryId: categoryid!, sorturl: urlHighToLow);
    } else {
      fetchSortCategoryAndPriceWiseProduct(sorturl: urlHighToLow);
    }
  }

  void addToCart(String productId, BuildContext context) async {
    productViewProvider.initialQuantity = '1';

    final result = await productViewProvider.addToCartFromHome(
      productId,
    );
    if (result == true) {
      cartProvider.fetchCartData();

      Fluttertoast.showToast(
        msg: 'Item added to cart successfully',
        backgroundColor: Colors.green,
        fontSize: 17,
      );
      Navigator.pop(context);
    }
  }
}
