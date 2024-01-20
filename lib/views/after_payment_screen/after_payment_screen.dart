// ignore_for_file: deprecated_member_use, must_be_immutable
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/shadow.dart';

class AfterPaymentScreen extends StatelessWidget {
  AfterPaymentScreen({super.key});
  CartProvider cartProvider = CartProvider();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/user_home_screen', (route) => false);

        return true;
      },
      child: Scaffold(
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
              height: height * .74,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: userAppBar,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                        'assets/lottie/Animation - 1699360467016.json'),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 70, left: 70),
                      child: NeuBox(
                        child: SizedBox(
                          height: height * .05,
                          width: width * .8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              cartProvider.fetchCartData();
                              Navigator.pushNamed(context, '/order_history');
                            },
                            child: const Text(
                              'Order History',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: NeuBox(
                        child: SizedBox(
                          height: height * .05,
                          width: width * .8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              cartProvider.fetchCartData();
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/user_home_screen', (route) => false);
                            },
                            child: const Text(
                              'Go to Home page',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
