import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/authentication/db_authentication/db_authentication.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/shadow.dart';

// ignore: must_be_immutable
class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _LonginPageState();
}

class _LonginPageState extends State<UserSignupPage> {
  TextEditingController name = TextEditingController();

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
                height: height * .01,
              ),
              Logo(
                height: height * 0.14,
              ),
              SizedBox(
                height: height * .01,
              ),
              const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Color.fromARGB(255, 194, 194, 194),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              Container(
                width: width * .8,
                decoration: const BoxDecoration(),
                child: NeuBox(
                  child: Container(
                    height: height * .5,
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
                        children: [
                          SizedBox(
                            height: height * 0.03,
                          ),
                          const Text(
                            'Create Account',
                            style: TextStyle(
                                color: loginColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * .1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * .02,
                              ),
                              const Text(
                                'Enter full name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .006,
                          ),
                          SizedBox(
                            height: height * .055,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: name,
                              decoration: InputDecoration(
                                hintText: 'Enter your full name here',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .1,
                          ),
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
                                'Next',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                final token = prefs.getString('token');
                                // ignore: use_build_context_synchronously
                                Provider.of<DbAuthService>(context,
                                        listen: false)
                                    .saveUserName(
                                        context, name.text, token.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(' '),
                    Image.asset(
                      'assets/images/burger_frenchfries.png',
                      height: 150,
                      width: 500,
                    ),
                  ],
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
