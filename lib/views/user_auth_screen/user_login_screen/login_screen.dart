import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/authentication/firebase_auth/firebase_authentication.dart';
import 'package:user_module/control/authentication/provider_login/login_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/shadow.dart';

// ignore: must_be_immutable
class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _LonginPageState();
}

class _LonginPageState extends State<UserLoginPage> {
  final FocusNode _focusNode = FocusNode();
  final mobilecontroller = TextEditingController();
  String countryCode = '+91';
  bool showProgress = false;
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Consumer<LoginProvider>(
            builder: (context, loginProvider, _) => Column(
              children: [
                loginProvider.showProgress
                    ? const SpinKitChasingDots(
                        color: Colors.blue,
                        size: 300,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .03,
                          ),
                          Logo(
                            height: height * 0.14,
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          Container(
                            width: width * .8,
                            decoration: const BoxDecoration(),
                            child: NeuBox(
                              child: Container(
                                height: height * .45,
                                width: width * .8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Log In',
                                        style: TextStyle(
                                            color: loginColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * .02,
                                              ),
                                              const Text(
                                                'Enter your phone number',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * .006,
                                          ),
                                          SizedBox(
                                            height: height * .055,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              focusNode: _focusNode,
                                              controller: mobilecontroller,
                                              decoration: InputDecoration(
                                                // prefixText: '+91',
                                                hintText: '  Enter your number',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: width * .64,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: buttonColor,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: const Text(
                                                'Login',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              onPressed: () {
                                                _focusNode.unfocus();

                                                String finalNumber =
                                                    countryCode +
                                                        mobilecontroller.text;

                                                loginProvider.setProgress(true);
                                                Provider.of<FireBaseAuthService>(
                                                        context,
                                                        listen: false)
                                                    .signInWithPhone(context,
                                                        finalNumber.trim());
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/burger_three_piece.png',
                                      height: 150,
                                      width: 395,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setToken(dynamic token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
