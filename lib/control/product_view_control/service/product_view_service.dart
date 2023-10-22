import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';

class ProductViewService {
  String addToCartUrl = ApiBaseUrl().baseUrl + ApiEndUrl().addToCart;
  Dio dio = Dio();

  Future<dynamic> addToCart(String productId, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    log('Product added to cart  : $productId');
    log('Product added to cart  : $quantity');
    try {
      Response response = await dio.post(
        addToCartUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {
          'quantity': quantity,
          'productId': productId,
        },
      );

      if (response.statusCode == 200) {
        log('Product added to cart successfully : ${response.data}');
        return true;
      } else {
        log('Failed to add product to cart : ${response.data}');
        return false;
      }
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }
}
