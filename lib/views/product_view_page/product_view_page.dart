import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/product_view_control/provider/product_view_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/product_view_page/widget/counter_widget.dart';
import 'package:user_module/views/product_view_page/widget/product_image.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/show_dialog.dart';

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

                                // RatingBar.builder(
                                //   initialRating: 5,
                                //   // minRating: 1,
                                //   itemCount: 5,
                                //   itemBuilder: (context, index) {
                                //     return const Icon(
                                //       Icons.star,
                                //       color: Colors.amber,
                                //       size: 10,
                                //     );
                                //   },
                                //   onRatingUpdate: (rating) {
                                //     print('Rating : $rating');
                                //     log('rating : $rating');
                                //   },
                                // ),
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
                                dynamic result =
                                    await Provider.of<ProductViewProvider>(
                                            context,
                                            listen: false)
                                        .addToCart(productId.toString());

                                if (result == true) {
                                  // ignore: use_build_context_synchronously
                                  showItemSnackBar(context,
                                      massage: 'Product added successfully',
                                      color: Colors.green);

                                  // ignore: use_build_context_synchronously
                                  Provider.of<ProductViewProvider>(context,
                                          listen: false)
                                      .initialQuantity = '1';
                                  // ignore: use_build_context_synchronously
                                  Provider.of<ProductViewProvider>(context,
                                          listen: false)
                                      .initialPrize = null;

                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacementNamed(
                                      context, '/cart_screen');
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showItemSnackBar(context,
                                      massage: 'something went wrong',
                                      color: Colors.red);
                                  return;
                                }
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
                                    'Add Item ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    // ignore: unnecessary_null_comparison
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
