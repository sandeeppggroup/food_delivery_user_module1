import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/model/address_model/address_model.dart';

class PaymentService {
  final codOrderUrl = ApiBaseUrl().baseUrl + ApiEndUrl().codOrder;
  Dio dio = Dio();

  Future<void> cashOnDelivery(AddressModel address, String paymentMode,
      String paymentType, int totalAmount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Response response = await dio.post(codOrderUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {
          'address': address,
          'payment': paymentMode,
          'paymentType': paymentType,
          'totalAmount': totalAmount
        });

    try {
      if (response.statusCode == 200) {
        log('cod status code: ${response.data.toString()}');
      } else {
        log('Something went wrong: ${response.data.toString()}');
      }
    } catch (e) {
      log('Error in COD : $e');
    }
  }
}
