// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/product_view_control/provider/product_view_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/product_view_screen/widget/counter_widget.dart';
import 'package:user_module/views/product_view_screen/widget/product_image.dart';
import 'package:user_module/widget/logo.dart';

// ignore: must_be_immutable
class ProductViewPage extends StatelessWidget {
  String? productId;
  String? imageUrl;
  String? name;
  String? description;
  String? price;
  ProductViewPage(
      {this.productId,
      this.imageUrl,
      this.name,
      this.description,
      this.price,
      super.key});

  @override
  Widget build(BuildContext context) {
    final productViewProviderWatch = (context).watch<ProductViewProvider>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductViewProvider>(context, listen: false)
            .initialQuantity = '1';
        Provider.of<ProductViewProvider>(context, listen: false).initialPrize =
            null;
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15.0, right: 15.0),
                        child: ProductImageContainer(imageUrl: imageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Container(
                          height: height * .2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.toString(),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 120,
                                  height: 20,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      );
                                    },
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  description.toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Price : ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      '₹$price',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CounterWidget(price: price.toString()),
                          SizedBox(
                            height: height * 0.045,
                            width: width * 0.6,
                            child: ElevatedButton(
                              onPressed: () async {
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
                                await Provider.of<ProductViewProvider>(context,
                                        listen: false)
                                    .addToCart(productId.toString(), context);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: buttonColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Add to cart ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '₹${(productViewProviderWatch.totalPrice) == null ? price : productViewProviderWatch.totalPrice.toString()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
