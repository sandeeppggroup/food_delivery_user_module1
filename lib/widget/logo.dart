import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;

  Logo({required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: Image.asset(
              'assets/images/RED_RABBIT_LOGO_FINAL_new_page-0001__1_-removebg (2).png'),
        ),
        const Text(
          'CHOOSE      YOUR      TASTE',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
