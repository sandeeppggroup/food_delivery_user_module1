// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/core/colors/colors.dart';

// ignore: must_be_immutable
class CounterWidgetCartPage extends StatelessWidget {
  String quantity;
  String productId;
  CounterWidgetCartPage(
      {required this.quantity, required this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    // final productViewProviderWatch = context.watch<ProductViewProvider>();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.04,
      width: width * 0.25,
      decoration: BoxDecoration(
          color: userAppBar,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 230, 39, 99),
              blurRadius: 7,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: buttonColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: InkWell(
              onTap: () async {
                await cartProvider.increaseOrDecreaseQuantity(
                    '-1', productId, context);
              },
              child: Container(
                height: height * 0.039,
                width: width * 0.08,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: const Center(
                    child: Icon(
                  Icons.remove,
                  color: buttonColor,
                  size: 28,
                )),
              ),
            ),
          ),
          Text(
            quantity,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: InkWell(
              onTap: () async {
                await cartProvider.increaseOrDecreaseQuantity(
                    '1', productId, context);
              },
              child: Container(
                height: height * 0.039,
                width: width * 0.08,
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(7)),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: buttonColor,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
