import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/product_view_control/provider/product_view_provider.dart';
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
    return SizedBox(
      height: height * 0.033,
      width: width * 0.21,
      child: Container(
        height: height * 0.045,
        width: width * 0.3,
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
                onTap: () {
                  cartProvider.increaseOrDecreaseQuantity('-1', productId);
                },
                child: Container(
                  height: height * 0.039,
                  width: width * 0.08,
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Center(
                    child: Text(
                      '-',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: buttonColor),
                    ),
                  ),
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
                onTap: () {
                  cartProvider.increaseOrDecreaseQuantity('1', productId);
                },
                child: Container(
                  height: height * 0.039,
                  width: width * 0.08,
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: buttonColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
