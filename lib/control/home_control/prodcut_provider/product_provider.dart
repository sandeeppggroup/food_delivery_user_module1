import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/service/home_service.dart';
import 'package:user_module/control/product_view_control/provider/product_view_provider.dart';
import 'package:user_module/model/home_model/product_model.dart';
import 'package:user_module/widget/show_dialog.dart';

class ProductProvider extends ChangeNotifier {
  HomeService homeService = HomeService();
  CategoryProvider categoryProvider = CategoryProvider();
  ProductViewProvider productViewProvider = ProductViewProvider();
  CartProvider cartProvider = CartProvider();

  List<ProductModel> _productList = [];

  ProductProvider() {
    fetchAllProducts();
  }

  List<ProductModel> get productlist => _productList;

  Future<void> fetchCategoryAndPriceWiseProduct(
      String categoryId, String categoryName) async {
    log('in fetchCategoryWiseProduct : $categoryId');
    _productList.clear();
    _productList = await homeService.getCategoryWiseProduct(categoryId);
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
    _productList = await homeService.getAllProduct();
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

    final result = await productViewProvider.addToCart(productId);
    if (result == true) {
      // ignore: use_build_context_synchronously
      cartProvider.fetchCartData();

      // ignore: use_build_context_synchronously
      showItemSnackBar(context,
          massage: 'Item added to cart successfully', color: Colors.green);
    }
  }
}
