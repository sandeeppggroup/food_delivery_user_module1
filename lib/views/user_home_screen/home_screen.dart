import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/control/order_history/porvider/order_history_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/user_home_screen/widget/category_listview.dart';
import 'package:user_module/views/user_home_screen/widget/drawer_and_person.dart';
import 'package:user_module/views/user_home_screen/widget/drawer_content.dart';
import 'package:user_module/views/user_home_screen/widget/heading_and_search.dart';
import 'package:user_module/views/user_home_screen/widget/product_listview.dart';
import 'package:user_module/widget/logo_drawer.dart';

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

  final FocusNode _focusNode = FocusNode();
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
        drawer: Drawer(
          backgroundColor: userAppBar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 54,
                      ),
                    ),
                    LogoDrawer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  customerName.toString(),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: .5,
              ),
              Column(
                children: [
                  DrawerContent(
                    icon: Icons.lock,
                    labelName: 'Change Password',
                    callbackFunction: () {},
                  ),
                  DrawerContent(
                    icon: Icons.edit,
                    labelName: 'Edit Profile',
                    callbackFunction: () {},
                  ),
                  DrawerContent(
                    icon: Icons.shopping_cart,
                    labelName: 'My Orders',
                    callbackFunction: () {
                      Navigator.pushNamed(context, '/order_history');
                    },
                  ),
                  DrawerContent(
                    icon: Icons.location_on,
                    labelName: 'My Address',
                    callbackFunction: () {
                      Navigator.pushNamed(context, '/address_screen');
                    },
                  ),
                  DrawerContent(
                    icon: Icons.security,
                    labelName: 'Priviacy Policy',
                    callbackFunction: () {},
                  ),
                  DrawerContent(
                    icon: Icons.info,
                    labelName: 'Terms & Condition',
                    callbackFunction: () {},
                  ),
                  DrawerContent(
                    icon: Icons.info,
                    labelName: 'About Us',
                    callbackFunction: () {},
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('token', '');

                        // ignore: use_build_context_synchronously
                        Navigator.restorablePushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(color: buttonColor, fontSize: 20),
                      ),
                    ),
                    const Text('Version : 1.0.0'),
                  ],
                ),
              ),
            ],
          ),
        ),
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
