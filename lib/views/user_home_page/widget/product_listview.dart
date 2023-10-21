import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/home_model/product_model.dart';

class ProductHomeListView extends StatelessWidget {
  const ProductHomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: height * 0.35,
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          List<ProductModel> products = productProvider.productlist;

          return products.isEmpty
              ? SizedBox(
                  height: 40,
                  width: 20,
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Lottie.asset(
                    fit: BoxFit.scaleDown,
                    height: 20,
                    width: 20,
                    'assets/lottie/animation_lnxbj7g2.json',
                  ),
                )
              : ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    ProductModel product = products[index];
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/product_view_screen');
                          },
                          child: Container(
                            height: height * 0.3,
                            width: width * 0.45,
                            decoration: BoxDecoration(
                                gradient: linearGradientProduct,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 110),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.15,
                                    child:
                                        Image.network(product.image.imageUrl),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      product.price.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.06,
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
