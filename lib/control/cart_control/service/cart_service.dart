import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';

class CartService {
  String cartUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getAllCartItems;
  Dio dio = Dio();

  Future<void> getAllCartItems() async {
    try {
      Response response = await dio.get(cartUrl);

      if (response.statusCode == 200) {
        log('get success :  ${response.data['data']}');
      } else {
        log('cart get is failed : ${response.statusCode} : ${response.data}');
      }
    } catch (e) {
      log('Error : $e');
    }
  }
}
