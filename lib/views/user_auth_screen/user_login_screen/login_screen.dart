import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_country_picker_nm/flutter_country_picker_nm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/authentication/firebase_auth/firebase_authentication.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final mobilecontroller = TextEditingController();
  String countryCode = '+91';
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = Country.IN;
  }

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
          child: Column(
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
              Form(
                key: formKey,
                child: Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Select Country',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .006,
                                ),
                                Row(
                                  children: [
                                    CountryPicker(
                                      dense: true,
                                      showFlag: true,
                                      showDialingCode: true,
                                      showName: true,
                                      onChanged: (Country country) {
                                        setState(() {
                                          selectedCountry = country;
                                        });
                                      },
                                      selectedCountry: selectedCountry,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .006,
                                ),
                                TextFormField(
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  focusNode: _focusNode,
                                  controller: mobilecontroller,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(20, 5, 5, 5),
                                    hintText: '  Enter your number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter phone number.';
                                    } else if (value.length < 10) {
                                      return 'Enter valid phone number.';
                                    }
                                    return null;
                                  },
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
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      _focusNode.unfocus();
                                      if (formKey.currentState!.validate()) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: buttonColor,
                                                color: Colors.amber,
                                                strokeWidth: 6,
                                                strokeAlign: 3,
                                              ),
                                            );
                                          },
                                        );
                                        formKey.currentState!.save();
                                        String finalNumber =
                                            '+${selectedCountry!.dialingCode}${mobilecontroller.text}';
                                        log('Final number : $finalNumber');
                                        Provider.of<FireBaseAuthService>(
                                                context,
                                                listen: false)
                                            .signInWithPhone(
                                                context, finalNumber.trim());
                                      }
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
        ),
      ),
    );
  }

  Future<void> setToken(dynamic token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
