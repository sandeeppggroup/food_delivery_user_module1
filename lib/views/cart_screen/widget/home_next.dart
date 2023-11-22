// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/place_order_delivery_screen/place_order_delivery_screen.dart';
import 'package:user_module/views/place_order_pickup_screen/place_order_pickep_screen.dart';

class HomeNextContainer extends StatelessWidget {
  int? cartSum;
  int? cartItemQuantity;
  HomeNextContainer(
      {super.key, required this.cartSum, required this.cartItemQuantity});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.15,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: buttonColor,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 21,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  cartItemQuantity == 0
                      ? const Text(
                          'NO ITEM ADDED',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : cartItemQuantity == 1
                          ? Text(
                              '$cartItemQuantity ITEM ADDED',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Text(
                              ' $cartItemQuantity ITEMS ADDED',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                ],
              ),
              Text('Total : ₹$cartSum',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: height * .04,
                width: width * 0.24,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/user_home_screen', (route) => false);
                  },
                  child: const Text('Home'),
                ),
              ),
              SizedBox(
                height: height * .04,
                width: width * 0.24,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: buttonColor),
                  onPressed: () {
                    if (cartSum == 0) {
                      Fluttertoast.showToast(
                          msg: 'Please add any item to cart',
                          backgroundColor: buttonColor,
                          fontSize: 17);
                      return;
                    }

                    if (cartProvider.selectedOption == 'pickup') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceOrderPickup(
                            cartSum: cartSum,
                          ),
                        ),
                      );
                    } else if (cartProvider.selectedOption == 'delivery') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceOrderDelivery(
                            cartSum: cartSum,
                          ),
                        ),
                      );
                      context.read<AddressProvider>().getFirstAddress();
                    } else {
                      Fluttertoast.showToast(
                          msg:
                              'Please select an option \n" Pickup or Delivery " ',
                          backgroundColor: Colors.deepPurple,
                          fontSize: 17);
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
