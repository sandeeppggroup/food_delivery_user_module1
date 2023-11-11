// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/views/user_home_screen/widget/product_listview.dart';

class AllProductAndMore extends StatelessWidget {
  const AllProductAndMore({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final categoryProviderWatch = context.watch<CategoryProvider>();
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    productProvider.fetchAllProducts();
                    categoryProvider.setCategoryName = null;
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('All products'),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .fetchAllProducts();
                    Navigator.pushNamed(context, '/search_screen');
                  },
                  child: const Text('More ..'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              Provider.of<CategoryProvider>(context).categoryName != null
                  ? categoryProviderWatch.categoryName.toString()
                  : 'All Products',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: ProductHomeListView(),
          ),
        ],
      ),
    );
  }
}
