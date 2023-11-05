import 'package:flutter/material.dart';

class LogoDrawer extends StatelessWidget {
  const LogoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 64,
          child: Image.asset(
              'assets/images/RED_RABBIT_LOGO_FINAL_new_page-0001__1_-removebg (2).png'),
        ),
        const Text(
          'CHOOSE      YOUR      TASTE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
