// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/cart_model/cart_model.dart';
import 'package:user_module/views/cart_screen/widget/cart_counter.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key, required this.cartItems});
  List<CartItem> cartItems;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: height * 0.45,
              width: double.infinity,
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  CartItem cartItem = cartItems[index];

                  return Card(
                    elevation: 0,
                    color: userAppBar,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Container(
                          width: width * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border:
                                  Border.all(color: Colors.white, width: 2.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                              cartItem.cartProduct.image.imageUrl),
                        ),
                      ),
                      title: Text(
                        cartItem.cartProduct.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('₹${cartItem.cartProduct.price}'),
                      trailing: Column(
                        children: [
                          CounterWidgetCartPage(
                              productId: cartItem.cartProduct.productid,
                              quantity: cartItem.quantity.toString()),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '₹${((cartItem.quantity) * (cartItem.cartProduct.price))}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
