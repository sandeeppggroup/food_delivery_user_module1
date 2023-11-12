import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/place_order_payment_provider/provider/place_order_payment_provider.dart';
import 'package:user_module/core/colors/colors.dart';

Future<void> bottomSheetPaymentOption(BuildContext context, int cartSum) async {
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
                      placeOrderPaymentProvider.cashOnDelivery(
                          'COD', cartSum, context);
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
                      placeOrderPaymentProvider.onlinePaymentBackend(
                          'Online', cartSum, context);
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
