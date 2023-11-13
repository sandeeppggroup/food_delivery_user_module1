import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/place_order_payment_provider/provider/place_order_payment_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/place_order_delivery_screen/place_order_delivery_screen.dart';

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
                      final addressProvider1 =
                          Provider.of<AddressProvider>(context, listen: false);
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
                      } else if (addressProvider1
                          .selectedAddress.name.isEmpty) {
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
                      final addressProvider1 =
                          Provider.of<AddressProvider>(context, listen: false);
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
                      } else if (addressProvider1
                          .selectedAddress.name.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'select your address',
                          backgroundColor: Colors.blue,
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 15,
                        );
                        Navigator.pushNamed(context, '/address_screen');
                        return;
                      }
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
