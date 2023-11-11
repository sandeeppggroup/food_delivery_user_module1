import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/control/order_history/porvider/order_history_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/user_home_screen/widget/allProducts_more.dart';
import 'package:user_module/views/user_home_screen/widget/category_listview.dart';
import 'package:user_module/views/user_home_screen/widget/drawer.dart';
import 'package:user_module/views/user_home_screen/widget/drawer_and_person.dart';
import 'package:user_module/views/user_home_screen/widget/heading_and_search.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String? customerName;

  Future<void> getCustomerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerName = prefs.getString('customerName');
  }

  final FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCustomerName();
    context.read<AddressProvider>().getFirstAddress();
    context.read<CartProvider>().fetchCartData();
    context.read<OrderHistoryProvider>().getAllOrders();
    context.read<AddressProvider>().getAllAddress();
    context.read<ProductProvider>().fetchAllProducts();
    context.read<CategoryProvider>().fetchCategories();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerHome(
          customerName: customerName,
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
                  child: DrawerAndPersonIcon(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: HeadingAndSearchBar(focusNode: focusNode),
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
                const AllProductAndMore(),
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
      ),
    );
  }
}
