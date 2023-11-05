import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/place_order_provider/place_order_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/add_address_screen/add_address_form/add_address_form.dart';
import 'package:user_module/widget/button1.dart';
import 'package:user_module/widget/button2.dart';
import 'package:user_module/widget/logo.dart';

// ignore: must_be_immutable
class PlaceOrderDelivery extends StatefulWidget {
  int? cartSum;
  PlaceOrderDelivery({super.key, this.cartSum});

  @override
  State<PlaceOrderDelivery> createState() => _PlaceOrderDeliveryState();
}

class _PlaceOrderDeliveryState extends State<PlaceOrderDelivery> {
  @override
  Widget build(BuildContext context) {
    final placeOrderProvider =
        Provider.of<PlaceOrderProvider>(context, listen: false);
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
            height: height * .7495,
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
                        onPressed: () {},
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 8),
                    child: Container(
                      height: height * 0.21,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 245, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sandeep Abraham',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  'Nediyeng P.O',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  'Sreekandapuram',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  'Kannur',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Text(
                                  'Pin - 670631',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97),
                                      fontSize: 17),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Phone - 8907444333',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 97, 97, 97),
                                        fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                            Icon(
                              Icons.location_city,
                              size: 70,
                              color: Color.fromARGB(255, 95, 183, 255),
                            )
                          ],
                        ),
                      ),
                    ),
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
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonSmall(
                          label: 'Add Address',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddAddressForm();
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.058,
                  ),
                  Container(
                    height: height * 0.13,
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
                              placeOrderProvider.makePayment(widget.cartSum!);
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
