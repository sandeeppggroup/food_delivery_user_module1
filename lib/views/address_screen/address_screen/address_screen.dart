import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/address_model/address_model.dart';
import 'package:user_module/widget/button2.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/show_dialog.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, '/user_home_screen', (route) => false);
          return true;
        },
        child: Column(
          children: [
            SizedBox(
              height: height * .04,
            ),
            Logo(height: height * .1),
            SizedBox(
              height: height * .01,
            ),
            Container(
              height: height * .77,
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
                          final selectedAddress =
                              addressProvider.selectedAddress;
                          log('adress length in ui :   ${allAddress.length}');
                          return SizedBox(
                            height: height * 0.6753,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: allAddress.length,
                              itemBuilder: (context, index) {
                                AddressModel address = allAddress[index];
                                return Column(
                                  children: [
                                    Container(
                                      height: height * 0.19,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            SizedBox(
                                              height: height * 0.5,
                                              width: width * 0.64,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                      '${address.address} (H),\n${address.post} (PO),'),
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
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  log('address id: ${address.id}');
                                                  showDeleteConfirmationDialog(
                                                      context,
                                                      onPressedFunction: () {
                                                    addressProvider
                                                        .deleteAddress(
                                                            address.id!,
                                                            context);
                                                    Navigator.pop(context);
                                                  },
                                                      massage:
                                                          'Are you sure you want to delete this address');
                                                },
                                                icon: const Icon(Icons.delete))
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
            SizedBox(
              height: height * 0.006,
            ),
            ButtonSmall(
              label: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
