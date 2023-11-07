import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/place_order_payment_provider/place_order_payment_provider.dart';

Future<void> bottomSheetPaymentOption(BuildContext context, int cartSum) async {
  final addressProvider = Provider.of<AddressProvider>(context, listen: false);
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  final placeOrderPaymentProvider =
      Provider.of<PlaceOrderPaymentProvider>(context, listen: false);
  return await showModalBottomSheet(
    backgroundColor: Colors.black,
    // barrierColor: Colors.blue,
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Cash On Delivery',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final address = addressProvider.selectedAddress;
                      final paymentType =
                          cartProvider.selectedOption.toString();

                      placeOrderPaymentProvider.cashOnDelivery(
                          address, 'COD', paymentType, cartSum, context);
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.moneyBill,
                      size: 40,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Online Payment',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      log('$cartSum');

                      final address = addressProvider.selectedAddress;
                      final orderType = cartProvider.selectedOption.toString();
                      final responseData =
                          await placeOrderPaymentProvider.onlinePaymentBackend(
                              address, 'Online', orderType, cartSum, context);
                      final amountToRazorpay = responseData['data']['amount'];
                      final orderId = responseData['data']['id'];

                      // ignore: use_build_context_synchronously
                      Provider.of<PlaceOrderPaymentProvider>(context,
                              listen: false)
                          .onlinePayment(amountToRazorpay, orderId);
                    },
                    child: const Icon(
                      Icons.credit_card,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
