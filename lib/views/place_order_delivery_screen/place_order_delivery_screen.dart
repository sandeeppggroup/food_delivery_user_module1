import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/button1.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/payment_option.dart';

// ignore: must_be_immutable
class PlaceOrderDelivery extends StatefulWidget {
  int? cartSum;
  PlaceOrderDelivery({super.key, this.cartSum});

  @override
  State<PlaceOrderDelivery> createState() => _PlaceOrderDeliveryState();
}

AddressProvider addressProvider = AddressProvider();

class _PlaceOrderDeliveryState extends State<PlaceOrderDelivery> {
  @override
  Widget build(BuildContext context) {
    final addressProviderWatch = (context).watch<AddressProvider>();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.08,
          ),
          Logo(height: height * 0.13),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * .73,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: userAppBar,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
                    child: SizedBox(
                      height: height * .045,
                      width: width * 0.35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Delivery'),
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Delivery Address',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 117, 117, 117),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/address_screen');
                        },
                        child: const Text(
                          'Change Address',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 2),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 8),
                    child: Container(
                      height: height * 0.24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 245, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addressProviderWatch.selectedAddress.name,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  addressProviderWatch.selectedAddress.address,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  addressProviderWatch.selectedAddress.post,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  addressProviderWatch.selectedAddress.street,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  addressProviderWatch.selectedAddress.city,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  '${addressProviderWatch.selectedAddress.state} - ${addressProviderWatch.selectedAddress.pin}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Phone - ${addressProviderWatch.selectedAddress.mobile}',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 97, 97, 97),
                                        fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                            const Icon(
                              Icons.location_on_outlined,
                              size: 70,
                              color: Color.fromARGB(255, 95, 183, 255),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 8),
                    child: Container(
                      height: height * 0.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 245, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 40.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Use current location',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Icon(
                              Icons.map,
                              color: Color.fromARGB(255, 95, 183, 255),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    height: height * 0.14,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 0),
                            blurRadius: 9,
                            spreadRadius: 0)
                      ],
                      color: Color.fromARGB(255, 228, 245, 255),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 95.0,
                            top: 35,
                          ),
                          child: ButtonBig(
                            label: '₹${widget.cartSum}            Place Order',
                            onPressed: () {
                              bottomSheetPaymentOption(
                                  context, widget.cartSum!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
