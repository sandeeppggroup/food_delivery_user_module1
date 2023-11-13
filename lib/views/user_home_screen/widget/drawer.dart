// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/user_home_screen/widget/drawer_content.dart';
import 'package:user_module/widget/logo_drawer.dart';

class DrawerHome extends StatelessWidget {
  String? customerName;

  DrawerHome({super.key, this.customerName});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Drawer(
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
              customerName == null ? ' ' : customerName.toString(),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
    );
  }
}
