import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/authentication/db_authentication/db_authentication.dart';
import 'package:user_module/control/authentication/firebase_auth/firebase_authentication.dart';
import 'package:user_module/control/authentication/provider_login/login_provider.dart';
import 'package:user_module/control/authentication/provider_otp/otp_provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/firebase_options.dart';
import 'package:user_module/views/splash/splash.dart';
import 'package:user_module/views/user_auth_page/user_login/login_page.dart';
import 'package:user_module/views/user_auth_page/user_signup/signup_page.dart';
import 'package:user_module/views/user_home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/user_login': (context) => const UserLoginPage(),
          '/user_signup': (context) => const UserSignupPage(),
          // '/otp_screen': (context) => const OTPScreen(),
          '/user_home_screen': (context) => UserHomeScreen(),
        },
      ),
    );
  }
}
