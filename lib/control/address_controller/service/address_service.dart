import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';

class AddressService {
  final addAddressUrl = ApiBaseUrl().baseUrl + ApiEndUrl().addAddress;
  final getAllAdress = ApiBaseUrl().baseUrl + ApiEndUrl().getAllAddress;
  Dio dio = Dio();

  Future<void> addAddress(
    String name,
    String address,
    String street,
    String post,
    String city,
    String pin,
    String state,
    String mobile,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Response response = await dio.post(addAddressUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {
          "name": name,
          "address": address,
          "street": street,
          "post": post,
          "city": city,
          "pin": pin,
          "state": state,
          "mobile": mobile
        });

    try {
      if (response.statusCode == 200) {
        log('response in address service success:  ${response.data.toString()}');
      } else {
        log('response in address service failed:  ${response.data.toString()}');
      }
    } catch (e) {
      log('Error in address service: $e');
    }
  }

  Future<void> getAllAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Response response = await dio.get(
      getAllAdress,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    try {
      if (response.statusCode == 200) {
        log('get all address : ${response.data.toString()}');
      } else {
        log('Something went worng: ${response.data.toString()}');
      }
    } catch (e) {
      log('Error $e');
    }
  }
}
