import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/home_model/product_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Your choice'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Price Sort :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    productProvider.sortProductLowToHigh();
                  },
                  child: const Icon(
                    Icons.arrow_upward,
                    size: 25,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    productProvider.sortProductHighToLow();
                  },
                  child: const Icon(
                    Icons.arrow_downward,
                    size: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              height: height * 0.055,
              width: width * 0.85,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 190, 189, 189),
                    blurRadius: 1,
                    offset: Offset(8, 8),
                  )
                ],
                color: userAppBar,
                // border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 65.0),
                child: SizedBox(
                  height: 38,
                  width: 250,
                  child: TextFormField(
                    onChanged: (value) async {
                      Future.delayed(const Duration(seconds: 1));
                      log(value.toString());
                      String searchUrl = value.toString();
                      productProvider.fetchSortCategoryAndPriceWiseProduct(
                          searchUrl: searchUrl);
                    },
                    focusNode: _focusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Food Here Foody',
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        size: 50,
                        color: Color.fromARGB(179, 190, 192, 192),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<ProductProvider>(
                      builder: (context, productProvider, child) {
                        final products = productProvider.productlist;
                        return Container(
                          height: height * 0.712,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              ProductModel product = products[index];

                              return Card(
                                elevation: 0,
                                color: userAppBar,
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 3),
                                    child: Container(
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.white, width: 2.5),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          Image.network(product.image.imageUrl),
                                    ),
                                  ),
                                  title: Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('₹${product.description}'),
                                  trailing: Text(
                                    '₹${product.price}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
