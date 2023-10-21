import 'package:flutter/material.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/logo.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
              decoration: BoxDecoration(
                  gradient: linearGradient,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Stack(
                    //   children: [
                    //     Positioned(
                    //       top: 20,
                    //       left: 20,
                    //       right: 20,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(
                    //             top: 15.0, left: 15.0, right: 15.0),
                    //         child: Container(
                    //           height: height * .2,
                    //           width: double.infinity,
                    //           decoration: const BoxDecoration(
                    //             color: Color.fromARGB(255, 250, 149, 185),
                    //             borderRadius: BorderRadius.only(
                    //                 topLeft: Radius.circular(30),
                    //                 topRight: Radius.circular(30)),
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15.0, right: 15.0),
                      child: Container(
                        height: height * .2,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 250, 149, 185),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Container(
                        height: height * .4,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),
                      ),
                    ),
                    Text('data'),
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
