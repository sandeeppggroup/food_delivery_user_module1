import 'package:flutter/material.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/logo.dart';

class PlaceOrderPickup extends StatelessWidget {
  const PlaceOrderPickup({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.08,
          ),
          Logo(height: height * 0.13),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * .7495,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: userAppBar,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
