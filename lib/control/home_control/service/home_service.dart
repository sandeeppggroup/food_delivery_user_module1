import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/model/home_model/category_model.dart';
import 'package:user_module/model/home_model/product_model.dart';

class HomeService {
  final categoryUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getCategory;

  final Dio dio = Dio();

  Future<List<CategoryModel>?> getAllCategory() async {
    try {
      Response response = await dio.get(categoryUrl);
      if (response.statusCode == 200) {
        log('category successfully get : ${response.data}');

        List<dynamic> categoryJsonList = response.data['data'];

        List<CategoryModel> categories = categoryJsonList
            .map((categoryList) => CategoryModel.fromJson(categoryList))
            .toList();

        return categories;
      } else {
        log("Failed to get category : ${response.statusCode}");
      }
    } catch (e) {
      log('Error : $e');
      return null;
    }
    return null;
  }

  Future<List<ProductModel>?> getAllProduct() async {
    final productUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getProduct;
    try {
      Response response = await dio.get(productUrl);
      if (response.statusCode == 200) {
        log('Product successfully get : ${response.data}');

        List<dynamic> productJaonList = response.data['data'];

        List<ProductModel> getAllProducts = productJaonList
            .map((productList) => ProductModel.fromJson(productList))
            .toList();

        return getAllProducts;
      } else {
        log("Failed to get Product : ${response.statusCode}");
      }
    } catch (e) {
      log('Error : $e');
      return null;
    }
    return null;
  }

  Future<List<ProductModel>?> getCategoryWiseProduct(String categoryId) async {
    String categoryWiseProductUrl =
        '/products?categoryId=$categoryId&name=&sort=';
    String finalUrl = ApiBaseUrl().baseUrl + categoryWiseProductUrl;

    try {
      Response response = await dio.get(finalUrl);

      if (response.statusCode == 200) {
        log('product get success  : ${response.data}');
        List<dynamic> productJsonList = response.data['data'];
        List<ProductModel> getCategoryWiseProductListLowToHigh = productJsonList
            .map((productList) => ProductModel.fromJson(productList))
            .toList();
        return getCategoryWiseProductListLowToHigh;
      } else {
        log('failed to get product ${response.data['message']}');
      }
    } catch (e) {
      log('Error : $e');
      return null;
    }
    return null;
  }

  Future<List<ProductModel>> getCategoryWiseProductHighToLow(
      {String categoryIdUrl = '',
      String sortUrl = '',
      String searchUrl = ''}) async {
    log('in home service searchUrl : ${searchUrl.toString()}');
    String categoryWiseProductUrl =
        '/products?categoryId=$categoryIdUrl&name=$searchUrl&sort=$sortUrl';
    log('in home service url check:  $categoryWiseProductUrl');
    String finalUrl = ApiBaseUrl().baseUrl + categoryWiseProductUrl;

    try {
      Response response = await dio.get(finalUrl);
      log('in home service data : ${response.data['data']}');

      if (response.statusCode == 200) {
        List<dynamic> productJsonList = response.data['data'];
        List<ProductModel> getCategoryWiseproductListHighToLow = productJsonList
            .map((productList) => ProductModel.fromJson(productList))
            .toList();
        return getCategoryWiseproductListHighToLow;
      } else {
        log('data is getting failed : ${response.data['message']}');
        return [];
      }
    } catch (e) {
      log('Error : $e');
      return [];
    }
  }
}
