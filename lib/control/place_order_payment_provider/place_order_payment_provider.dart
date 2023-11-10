import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/place_order_payment_provider/provider/payment_service.dart';
import 'package:user_module/model/address_model/address_model.dart';

class PlaceOrderPaymentProvider extends ChangeNotifier {
  PaymentService paymentService = PaymentService();
  AddressProvider addressProvider = AddressProvider();
  CartProvider cartProvider = CartProvider();
  late BuildContext context;
  Razorpay? _razorpay;

  PlaceOrderPaymentProvider() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: 'PAYMENT SUCCESS : ${response.paymentId} , ${response.orderId}',
        timeInSecForIosWeb: 3);

    log('handlePaymentSuccess : orderId : ${response.orderId}, paymentId : ${response.paymentId} , signature : ${response.signature} ');
    log('message : ${response.toString()}');
    final deliveryType = cartProvider.selectedOption;

    log('delivey or pickup :  ${deliveryType.toString()},${addressProvider.selectedAddress.toString()}');

    final result = await paymentService.onlinePayment(
        response.paymentId.toString(),
        response.orderId.toString(),
        response.signature.toString());

    if (result == true) {
      cartProvider.fetchCartData();

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, '/after_payment_screen', (route) => false);
    }
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

  void onlinePayment(int cartSum, String orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerPhoneNumber = prefs.getString('phoneNumber');
    String? customerName = prefs.getString('customerName');

    int totalPayment = cartSum;

    log('details - PhoneNumber: $customerPhoneNumber, name: $customerName, payment: ${totalPayment.toString()}');

    //   String orderId = "order_${DateTime.now().millisecondsSinceEpoch}"; // Generate a unique order ID
    // String signature = generateSignature(orderId, totalPayment);
    var options = {
      'key': 'rzp_test_gpsSZl75alIqZ8',
      'amount': totalPayment, // which means Rs 200
      'name': customerName,
      'order_id': orderId,
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

  Future<dynamic> onlinePaymentBackend(AddressModel address, String paymentMode,
      String orderType, int totalAmount, BuildContext buildContext) async {
    context = buildContext;
    dynamic result = await paymentService.onlinePaymentDataBase(
        address, paymentMode, orderType, totalAmount);
    log('in Provider : ${result.toString()}');

    return result;
  }

  Future<bool> cashOnDelivery(AddressModel address, String paymentMode,
      String paymentType, int totalAmount, BuildContext context) async {
    CartProvider cartProvider = CartProvider();

    bool result = await paymentService.cashOnDelivery(
        address, paymentMode, paymentType, totalAmount);
    if (result == true) {
      cartProvider.fetchCartData();
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, '/after_payment_screen', (route) => false);
    }

    return result;
  }
}
