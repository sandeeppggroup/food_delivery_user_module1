import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/model/order_history_model/order_history_model.dart';

class OrderHistoryService {
  final getAllOrderUrl = ApiBaseUrl().baseUrl + ApiEndUrl().getAllOrders;
  final cancelOrderUrl = ApiBaseUrl().baseUrl + ApiEndUrl().cancelOrder;
  Dio dio = Dio();

  Future<dynamic> getAllOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    log("token: $token");
    Response response = await dio.get(
      getAllOrderUrl,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    log('status code: ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        // log('success : ${response.data['orderData']}');

        List<dynamic> orderHistoryJson = response.data['orderData'];
        // log("message : ${orderHistoryJson.toString()}");
        List<OrderData> orderData = orderHistoryJson
            .map((orderHistoryData) => OrderData.fromJson(orderHistoryData))
            .toList();

        log('total amount : ${orderData.length.toString()}');
        return orderData;
      } else {
        log('Failed to get : ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }

  Future<dynamic> cancelOrder(String orderId) async {
    final cancelUrlFinal = cancelOrderUrl + orderId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    log("token: $token");

    try {
      Response response = await dio.post(
        cancelUrlFinal,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {'orderStatus': 'cancelled'},
      );

      log('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        log('success : ${response.data.toString()}');
        return true;
      } else {
        log('Failed to get : ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }
}
