import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/model/home_model/category_model.dart';
import 'package:user_module/model/home_model/product_model.dart';

class HomeService {
  final categoryUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getCategory;
  final productUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getProduct;
  final Dio dio = Dio();

  Future<List<CategoryModel>> getAllCategory() async {
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
        return [];
      }
    } catch (e) {
      log('Error : $e');
      return [];
    }
    // return [];
  }

  Future<List<ProductModel>> getAllProduct() async {
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
      return [];
    }
    return [];
  }

  Future<List<ProductModel>> getCategoryWiseProduct(String categoryId) async {
    String categoryWiseProductUrl =
        '/products?categoryId=$categoryId&name=&sort=lowToHigh';
    String finalUrl = ApiBaseUrl().baseUrl + categoryWiseProductUrl;

    try {
      Response response = await dio.get(finalUrl);

      if (response.statusCode == 200) {
        log('product get success  : ${response.data}');
        List<dynamic> productJsonList = response.data['data'];
        List<ProductModel> getCategoryWiseProducts = productJsonList
            .map((productList) => ProductModel.fromJson(productList))
            .toList();
        return getCategoryWiseProducts;
      } else {
        log('failed to get product ${response.data['message']}');
      }
    } catch (e) {
      log('Error : $e');
      return [];
    }
    return [];
  }
}
