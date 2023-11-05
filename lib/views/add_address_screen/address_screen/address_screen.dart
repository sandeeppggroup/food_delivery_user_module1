import 'package:flutter/material.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/logo.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AddressProvider addressProvider = AddressProvider();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * .07,
          ),
          Logo(height: height * .1),
          SizedBox(
            height: height * .03,
          ),
          Container(
            height: height * .78,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: userAppBar,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'My Addresses',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: buttonColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_address_form');
                          },
                          child: const Text(
                            'Add a new address',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Container(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          height: height * 0.1,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 224, 224, 224)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
