import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/user_home_screen/widget/category_listview.dart';
import 'package:user_module/views/user_home_screen/widget/drawer_and_person.dart';
import 'package:user_module/views/user_home_screen/widget/heading_and_search.dart';
import 'package:user_module/views/user_home_screen/widget/product_listview.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final categoryProviderWatch = context.watch<CategoryProvider>();
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
                child: DrawerAndPersonIcon(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: HeadingAndSearchBar(),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: CategoryHomeListView(),
                    ),
                  ],
                ),
              ),
              Align(
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
                        Provider.of<CategoryProvider>(context).categoryName !=
                                null
                            ? categoryProviderWatch.categoryName.toString()
                            : 'All Products',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: ProductHomeListView(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 310),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 21,
                    backgroundColor: buttonColor,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart_screen');
                        Provider.of<CartProvider>(context, listen: false)
                            .fetchCartData();
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
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
