// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/address_controller/provider/address_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/address_model/address_model.dart';
import 'package:user_module/views/address_screen/add_address_form/widget/address_form_textform.dart';
import 'package:user_module/widget/button2.dart';
import 'package:user_module/widget/logo.dart';

class AddAddressForm extends StatelessWidget {
  AddAddressForm({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController post = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController mobile = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.034,
            ),
            Logo(height: height * 0.06),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              height: height * .875,
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
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Text(
                          'List your address',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          AddressFormTextForm(
                            length: 15,
                            focusNode: focusNode,
                            controller: name,
                            label: 'Name',
                            hintText: 'Enter your name',
                            keyBordType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your full name.';
                              }
                              return null;
                            },
                          ),
                          AddressFormTextForm(
                            length: 20,
                            focusNode: focusNode,
                            controller: address,
                            label: 'Address',
                            hintText: 'Enter your address',
                            keyBordType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your address.';
                              }
                              return null;
                            },
                          ),
                          AddressFormTextForm(
                            length: 20,
                            focusNode: focusNode,
                            controller: street,
                            label: 'Street',
                            hintText: 'Enter your street',
                            keyBordType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your street.';
                              }
                              return null;
                            },
                          ),
                          AddressFormTextForm(
                            length: 20,
                            focusNode: focusNode,
                            controller: post,
                            label: 'Post',
                            hintText: 'Enter your post (PO)',
                            keyBordType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter post (PO).';
                              }
                              return null;
                            },
                          ),
                          AddressFormTextForm(
                            length: 15,
                            focusNode: focusNode,
                            controller: city,
                            label: 'City',
                            hintText: 'Enter your city name',
                            keyBordType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your city name.';
                              }
                              return null;
                            },
                          ),
                          AddressFormTextForm(
                            length: 6,
                            focusNode: focusNode,
                            controller: pin,
                            label: 'Pin Code',
                            hintText: 'Enter your pin code',
                            keyBordType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter pin code.';
                              } else if (value.length < 6 || value.length > 6) {
                                return 'Enter valid pin code.';
                              }
                              return null;
                            },
                          ),
                          AddressFormTextForm(
                            length: 15,
                            focusNode: focusNode,
                            controller: state,
                            label: 'State',
                            hintText: 'Enter your state',
                            keyBordType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter state.';
                              }
                              return null;
                            },
                          ),
                          AddressFormTextForm(
                            length: 10,
                            focusNode: focusNode,
                            controller: mobile,
                            label: 'Mobile Number',
                            hintText: 'Enter your mobile number',
                            keyBordType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter phone number.';
                              } else if (value.length != 10) {
                                return 'Enter valid phone number.';
                              }
                              return null;
                            },
                          ),
                          ButtonSmall(
                            label: "Submit",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                int finalPin = int.parse(pin.text);
                                Provider.of<AddressProvider>(context,
                                        listen: false)
                                    .addAddress(
                                        AddressModel(
                                          name: name.text.trim(),
                                          address: address.text.trim(),
                                          street: street.text.trim(),
                                          post: post.text.trim(),
                                          city: city.text.trim(),
                                          pin: finalPin,
                                          state: state.text.trim(),
                                          mobile: mobile.text.trim(),
                                        ),
                                        context);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
