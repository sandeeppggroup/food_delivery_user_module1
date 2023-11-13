import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/cart_model/cart_model.dart';
import 'package:user_module/views/cart_screen/widget/home_next.dart';
import 'package:user_module/views/cart_screen/widget/pickup_delivery.dart';
import 'package:user_module/views/cart_screen/widget/product_list.dart';
import 'package:user_module/widget/logo.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, '/user_home_screen', (route) => false);
          return true;
        },
        child: SingleChildScrollView(
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              List<CartItem> cartItems = cartProvider.cartProducts;

              int cartSum = 0;
              for (CartItem cartItem in cartItems) {
                cartSum += (cartItem.quantity) * (cartItem.cartProduct.price);
              }

              // cartSum += (cartItem.quantity)*(cartItem.cartProduct.price);
              return Column(
                children: [
                  SizedBox(
                    height: height * .07,
                  ),
                  Logo(height: height * .13),
                  SizedBox(
                    height: height * .03,
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
                          const PickupDelivery(),
                          const Divider(
                            color: Colors.white,
                            thickness: 1.5,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Items Added',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1.5,
                          ),
                          ProductList(cartItems: cartItems),
                          HomeNextContainer(
                              cartSum: cartSum,
                              cartItemQuantity: cartItems.length),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
