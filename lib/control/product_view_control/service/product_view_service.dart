import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';

class ProductViewService {
  String addToCartUrl = ApiBaseUrl().baseUrl + ApiEndUrl().addToCart;
  Dio dio = Dio();

  Future<dynamic> addToCart(String productId, int quantity) async {
    try {
      Response response = await dio.post(
        addToCartUrl,
        data: {
          'quantity': quantity,
          'productId': productId,
        },
      );

      if (response.statusCode == 200) {
        log('Product added to cart successfully : ${response.data}');
        return response.data;
      } else {
        log('Failed to add product to cart : ${response.data}');
        return response.data;
      }
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }
}
