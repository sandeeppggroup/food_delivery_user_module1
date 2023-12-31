import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/control/authentication/db_authentication/db_authentication.dart';
import 'package:user_module/control/authentication/firebase_auth/firebase_authentication.dart';
import 'package:user_module/control/authentication/provider_otp/otp_provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/control/order_history/porvider/order_history_provider.dart';
import 'package:user_module/control/place_order_pickup/pickup_provider.dart';
import 'package:user_module/control/place_order_payment_provider/provider/place_order_payment_provider.dart';
import 'package:user_module/control/product_view_control/provider/product_view_provider.dart';
import 'package:user_module/firebase_options.dart';
import 'package:user_module/views/address_screen/add_address_form/add_address_form.dart';
import 'package:user_module/views/address_screen/address_screen/address_screen.dart';
import 'package:user_module/views/after_payment_screen/after_payment_screen.dart';
import 'package:user_module/views/cart_screen/cart_screen.dart';
import 'package:user_module/views/order_history/order_history.dart';
import 'package:user_module/views/place_order_delivery_screen/place_order_delivery_screen.dart';
import 'package:user_module/views/place_order_pickup_screen/place_order_pickep_screen.dart';
import 'package:user_module/views/product_view_screen/product_view_screen.dart';
import 'package:user_module/views/search_screen/search_screen.dart';
import 'package:user_module/views/splash_screen/splash_screen.dart';
import 'package:user_module/views/user_auth_screen/user_login_screen/login_screen.dart';
import 'package:user_module/views/user_auth_screen/user_signup_screen/signup_page.dart';
import 'package:user_module/views/user_home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                FireBaseAuthService(auth: FirebaseAuth.instance)),
        ChangeNotifierProvider(create: (context) => DbAuthService()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ProductViewProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => PickupProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(
            create: (context) => PlaceOrderPaymentProvider()),
        ChangeNotifierProvider(create: (context) => OrderHistoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/user_login': (context) => const UserLoginPage(),
          '/user_signup': (context) => const UserSignupPage(),
          '/user_home_screen': (context) => const UserHomeScreen(),
          '/product_view_screen': (context) => ProductViewPage(),
          '/cart_screen': (context) => const CartPage(),
          '/search_screen': (context) => SearchScreen(),
          '/place_order_pickup': (context) => PlaceOrderPickup(),
          '/place_order_delivery': (context) => PlaceOrderDelivery(),
          '/add_address_form': (context) => AddAddressForm(),
          '/address_screen': (context) => const AddressScreen(),
          '/order_history': (context) => const OrderHistoryScreen(),
          '/after_payment_screen': (context) => AfterPaymentScreen(),
        },
      ),
    );
  }
}
