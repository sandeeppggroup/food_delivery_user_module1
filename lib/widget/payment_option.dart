import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/place_order_payment_provider/place_order_payment_provider.dart';
import 'package:user_module/control/place_order_payment_provider/provider/payment_service.dart';
import 'package:user_module/model/address_model/address_model.dart';

Future<void> bottomSheetPaymentOption(BuildContext context, int cartSum) async {
  PaymentService paymentService = PaymentService();
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
                        final address =
                            Provider.of<AddressProvider>(context, listen: false)
                                .selectedAddress;
                        final paymentType =
                            Provider.of<CartProvider>(context, listen: false)
                                .selectedOption
                                .toString();
                        Provider.of<PlaceOrderPaymentProvider>(context,
                                listen: false)
                            .cashOnDelivery(
                                address, 'COD', paymentType, cartSum);
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.moneyBill,
                        size: 40,
                      )),
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
                    onPressed: () {
                      Provider.of<PlaceOrderPaymentProvider>(context,
                              listen: false)
                          .onlinePayment(cartSum);
                      Navigator.pop(context);
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
