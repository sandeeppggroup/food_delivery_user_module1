import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/model/address_model/address_model.dart';

class PaymentService {
  final codOrderUrl = ApiBaseUrl().baseUrl + ApiEndUrl().codOrder;
  final onlinePaymentUrl = ApiBaseUrl().baseUrl + ApiEndUrl().onlinePayment;
  final verifyPaymentUrl = ApiBaseUrl().baseUrl + ApiEndUrl().verifypayment;
  int? onlineTotalAmount;
  AddressModel? onlineAddress;
  String? onlineOrderType;
  String? onlinePaymentMode;
  String? onlinePickupDate;
  String? onlinePickupTime;

  Dio dio = Dio();

  Future<bool> cashOnDelivery(AddressModel address, String paymentMode,
      String orderType, int totalAmount,
      {String? selectedDate, String? selectedTime}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    log('address: ${address.name}');
    Response response = await dio.post(
      codOrderUrl,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: orderType == 'delivery'
          ? {
              'address': address,
              'payment': paymentMode,
              'paymentType': orderType,
              'totalAmount': totalAmount,
            }
          : {
              'address': address,
              'payment': paymentMode,
              'paymentType': orderType,
              'totalAmount': totalAmount,
              'pickupDate': selectedDate,
              'pickupTime': selectedTime,
            },
    );

    try {
      if (response.statusCode == 200) {
        log('cod status code: ${response.data.toString()}');
        return response.data['success'];
      } else {
        log('Something went wrong: ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Error in COD : $e');
      return false;
    }
  }

  Future<bool> onlinePayment(
      String paymentId, String orderId, String signature) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    log('total Amount : $onlineTotalAmount , address : ${onlineAddress!.name} , ordertype : $onlineOrderType , paymentMode : $onlinePaymentMode');

    Response response = await dio.post(
      verifyPaymentUrl,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: onlineOrderType == 'delivery'
          ? {
              'address': onlineAddress,
              'payment': onlinePaymentMode,
              'paymentType': onlineOrderType,
              'totalAmount': onlineTotalAmount,
              'razorpay_payment_id': paymentId,
              'razorpay_order_id': orderId,
              'razorpay_signature': signature,
            }
          : {
              'address': onlineAddress,
              'payment': onlinePaymentMode,
              'paymentType': onlineOrderType,
              'totalAmount': onlineTotalAmount,
              'pickupDate': onlinePickupDate,
              'pickupTime': onlinePickupTime,
              'razorpay_payment_id': paymentId,
              'razorpay_order_id': orderId,
              'razorpay_signature': signature,
            },
    );

    try {
      if (response.statusCode == 200) {
        log('cod status code: ${response.data.toString()}');
        return response.data['success'];
      } else {
        log('Something went wrong: ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Error in COD : $e');
      return false;
    }
  }

  Future<dynamic> onlinePaymentDataBase(AddressModel address,
      String paymentMode, String orderType, int totalAmount,
      {String? selectedDate, String? selectedTime}) async {
    onlineAddress = address;
    onlinePaymentMode = paymentMode;
    onlineOrderType = orderType;
    onlineTotalAmount = totalAmount;
    onlinePickupDate = selectedDate;
    onlinePickupTime = selectedTime;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Response response = await dio.post(onlinePaymentUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {'totalAmount': totalAmount});

    try {
      if (response.statusCode == 200) {
        log('online Payment : ${response.data['data']['amount']}');

        dynamic responseData = response.data;
        return responseData;
      } else {
        log('Failed Payment : ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }
}
