import 'package:flutter/material.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/product_view_page/widget/counter_widget.dart';
import 'package:user_module/views/product_view_page/widget/product_image.dart';
import 'package:user_module/widget/logo.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * .1,
            ),
            Logo(height: height * .13),
            Container(
              height: height * .7495,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: userAppBar,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                      child: ProductImageContainer(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Container(
                        height: height * .2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Compo Burger',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                'Herb tikki, salsa and cheese',
                                style: TextStyle(fontSize: 20),
                              ),
                              Spacer(),
                              Text('Price : ₹120')
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CounterWidget(),
                        SizedBox(
                          height: height * 0.045,
                          width: width * 0.6,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: buttonColor),
                            child: const Text('Add Item ₹120'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
