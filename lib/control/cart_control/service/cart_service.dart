import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/model/cart_model/cart_model.dart';

class CartService {
  String cartUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getAllCartItems;
  Dio dio = Dio();

  Future<dynamic> getAllCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    log('token in cart : $token');
    try {
      Response response = await dio.get(
        cartUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        log('get success :  ${response.data['data']['products']}');
        List<dynamic> cartJson = response.data['data']['products'];
        List<CartItem> cartItems = cartJson
            .map((cartItemList) => CartItem.fromJson(cartItemList))
            .toList();

        log('log in cart after success  : ${cartItems}');
        return cartItems;
      } else {
        log('cart get is failed : ${response.statusCode} : ${response.data}');
        return [];
      }
    } catch (e) {
      log('Error : $e');
      return [];
    }
  }
}
