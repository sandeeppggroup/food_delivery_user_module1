// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/place_order_payment_provider/service/payment_service.dart';
import 'package:user_module/control/place_order_pickup/pickup_provider.dart';
import 'package:user_module/core/colors/colors.dart';
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

  Future<void> onlinePaymentBackend(
    String paymentMode,
    int totalAmount,
    BuildContext buildContext,
  ) async {
    context = buildContext;

    final addressProvider1 =
        Provider.of<AddressProvider>(context, listen: false);
    final cartProvider1 = Provider.of<CartProvider>(context, listen: false);
    final pickupProvider = Provider.of<PickupProvider>(context, listen: false);

    if (addressProvider.selectedAddress.pin == 0 &&
        addressProvider1.addressList.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please add your address',
        backgroundColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 15,
      );
      Navigator.pushNamed(context, '/add_address_form');
      return;
    } else if (addressProvider1.selectedAddress.name.isEmpty) {
      Fluttertoast.showToast(
        msg: 'select your address',
        backgroundColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 15,
      );
      Navigator.pushNamed(context, '/address_screen');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: buttonColor,
            color: Colors.amber,
            strokeWidth: 6,
            strokeAlign: 3,
          ),
        );
      },
    );

    AddressModel address = addressProvider1.selectedAddress;
    String orderType = cartProvider1.selectedOption.toString();
    final pickupdate = pickupProvider.selectedDay;
    final pickupTime = pickupProvider.selectedTime;

    dynamic responseData = await paymentService.onlinePaymentDataBase(
        address, paymentMode, orderType, totalAmount,
        selectedDate: pickupdate.toString(),
        selectedTime: pickupTime.toString());

    log('in Provider : ${responseData.toString()}');

    final amountToRazorpay = responseData['data']['amount'];
    final orderId = responseData['data']['id'];

    onlinePayment(amountToRazorpay, orderId);
  }

  Future<void> cashOnDelivery(
      String paymentMode, int totalAmount, BuildContext context) async {
    final addressProvider1 =
        Provider.of<AddressProvider>(context, listen: false);
    final cartProvider1 = Provider.of<CartProvider>(context, listen: false);
    final pickupProvider = Provider.of<PickupProvider>(context, listen: false);

    log('in online :  ${addressProvider1.selectedAddress.name}');

    if (addressProvider.selectedAddress.pin == 0 &&
        addressProvider1.addressList.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please add your address',
        backgroundColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 15,
      );
      Navigator.pushNamed(context, '/add_address_form');
      return;
    } else if (addressProvider1.selectedAddress.name.isEmpty) {
      Fluttertoast.showToast(
        msg: 'select your address',
        backgroundColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 15,
      );
      Navigator.pushNamed(context, '/address_screen');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: buttonColor,
            color: Colors.amber,
            strokeWidth: 6,
            strokeAlign: 3,
          ),
        );
      },
    );

    final address = addressProvider1.selectedAddress;
    final paymentType = cartProvider1.selectedOption.toString();
    final pickupdate = pickupProvider.selectedDay;
    final pickupTime = pickupProvider.selectedTime;

    log('Address : ${address.name}');
    bool result = await paymentService.cashOnDelivery(
        address, paymentMode, paymentType, totalAmount,
        selectedDate: pickupdate.toString(),
        selectedTime: pickupTime.toString());
    if (result == true) {
      cartProvider.fetchCartData();

      Navigator.pushNamedAndRemoveUntil(
          context, '/after_payment_screen', (route) => false);
    } else {
      Fluttertoast.showToast(
        msg: 'Payment failed',
        backgroundColor: buttonColor,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pop(context);
    }
  }

  Future<bool> cashOnPickup(AddressModel address, String paymentMode,
      String paymentType, int totalAmount, BuildContext context) async {
    CartProvider cartProvider = CartProvider();

    bool result = await paymentService.cashOnDelivery(
        address, paymentMode, paymentType, totalAmount);
    if (result == true) {
      cartProvider.fetchCartData();

      Navigator.pushNamedAndRemoveUntil(
          context, '/after_payment_screen', (route) => false);
    }

    return result;
  }
}
