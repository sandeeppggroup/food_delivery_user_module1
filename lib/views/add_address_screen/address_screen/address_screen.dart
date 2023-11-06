import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/address_model/address_model.dart';
import 'package:user_module/widget/logo.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
                  SingleChildScrollView(
                    child: Consumer<AddressProvider>(
                      builder: (context, addressProvider, _) {
                        final allAddress = addressProvider.addressList;
                        final selectedAddress = addressProvider.selectedAddress;
                        log('adress length in ui :   ${allAddress.length}');
                        return Container(
                          height: height * 0.6753,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: allAddress.length,
                            itemBuilder: (context, index) {
                              AddressModel address = allAddress[index];
                              return Column(
                                children: [
                                  Container(
                                    height: height * 0.17,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Radio<AddressModel>(
                                            value: address,
                                            groupValue: selectedAddress,
                                            onChanged: (selectedAddress) {
                                              // log('in sddress screen ${selectedAddress!.name.toString()}');

                                              addressProvider
                                                  .toggleAddressSelection(
                                                      selectedAddress!);
                                            },
                                          ),
                                          // Checkbox(value: value, onChanged: onChanged),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                address.name,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                  '${address.address} (H), ${address.post} (PO),'),
                                              Text(
                                                  '${address.street}, ${address.city},'),
                                              Text(
                                                  '${address.state} - ${address.pin}'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(address.mobile),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                ],
                              );
                            },
                          ),
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
