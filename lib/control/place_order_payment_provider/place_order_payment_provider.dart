import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/place_order_payment_provider/provider/payment_service.dart';
import 'package:user_module/model/address_model/address_model.dart';

class PlaceOrderPaymentProvider extends ChangeNotifier {
  Razorpay? _razorpay;

  PlaceOrderPaymentProvider() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'PAYMENT SUCCESS : ${response.paymentId}', timeInSecForIosWeb: 3);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'PAYMENT FAILED : ${response.code} - ${response.message}',
        timeInSecForIosWeb: 3);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'EXTERNAL WALLET IS : ${response.walletName}',
        timeInSecForIosWeb: 3);
  }

  void onlinePayment(int cartSum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerPhoneNumber = prefs.getString('phoneNumber');
    String? customerName = prefs.getString('customerName');

    int totalPayment = cartSum * 100;

    log('details - PhoneNumber: $customerPhoneNumber, name: $customerName, payment: ${totalPayment.toString()}');
    var options = {
      'key': 'rzp_test_gpsSZl75alIqZ8',
      'amount': totalPayment, // which means Rs 200
      'name': customerName,
      'description': 'Red Rabbit',
      'prefill': {
        'contact': customerPhoneNumber,
        'email': 'sandeep.pggroup@gmail.com'
      }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> cashOnDelivery(AddressModel address, String paymentMode,
      String paymentType, int totalAmount) async {
    PaymentService paymentService = PaymentService();
    CartProvider cartProvider = CartProvider();

    final result = await paymentService.cashOnDelivery(
        address, paymentMode, paymentType, totalAmount);

    cartProvider.cartProducts.clear();
  }
}
