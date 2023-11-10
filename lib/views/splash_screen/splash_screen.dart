// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/authentication/db_authentication/db_authentication.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/control/order_history/porvider/order_history_provider.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/show_dialog.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  DbAuthService dbAuthService = DbAuthService();
  @override
  void initState() {
    super.initState();
    tokenStatusChecking();
    // tokenStatusCheckingAndFetch();
  }

  Future<void> tokenStatusCheckingAndFetch() async {
    bool result = await tokenStatusChecking();

    if (result == true) {
      context.read<AddressProvider>().getFirstAddress();
      context.read<CartProvider>().fetchCartData();
      context.read<OrderHistoryProvider>().getAllOrders();
      context.read<AddressProvider>().getAllAddress();
      context.read<ProductProvider>().fetchAllProducts();
      context.read<CategoryProvider>().fetchCategories();
    } else {
      return;
    }
  }

  Future<bool> tokenStatusChecking() async {
    final tokenStatus = await dbAuthService.checkTokenStatus();
    if (tokenStatus != false && tokenStatus['success'] == true) {
      showItemSnackBar(context,
          massage: '${tokenStatus['message']}', color: Colors.green);

      Navigator.pushReplacementNamed(context, '/user_home_screen');
      return true;
    } else {
      Navigator.pushReplacementNamed(context, '/user_login');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Logo(height: height * 0.2),
            SizedBox(
              height: height * 0.2,
            ),
            SizedBox(
              height: height * 0.45,
              child: Image.asset('assets/images/cake_birthday_drowing1.png'),
            ),
          ],
        ),
      ),
    );
  }
}
