import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';

class OrderHistoryService {
  final getAllOrderUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getAllOrders;
  Dio dio = Dio();

  Future<dynamic> getAllOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Response response = await dio.get(
      getAllOrderUrl,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    try {
      if (response.statusCode == 200) {
        log('success : ${response.data.toString()}');
      } else {
        log('Failed to get : ${response.data.toString()}');
      }
    } catch (e) {
      log('Error : $e');
    }
  }
}
