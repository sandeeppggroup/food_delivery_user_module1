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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            Logo(height: height * 0.08),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              height: height * .83,
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
                    Column(
                      children: [
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: name,
                          label: 'Name',
                          hintText: 'Enter your name',
                          keyBordType: TextInputType.name,
                        ),
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: address,
                          label: 'Address',
                          hintText: 'Enter your sddress',
                          keyBordType: TextInputType.streetAddress,
                        ),
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: street,
                          label: 'Street',
                          hintText: 'Enter your street',
                          keyBordType: TextInputType.streetAddress,
                        ),
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: post,
                          label: 'Post',
                          hintText: 'Enter your post',
                          keyBordType: TextInputType.streetAddress,
                        ),
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: city,
                          label: 'City',
                          hintText: 'Enter your city',
                          keyBordType: TextInputType.streetAddress,
                        ),
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: pin,
                          label: 'Pin Code',
                          hintText: 'Enter your pin code',
                          keyBordType: TextInputType.number,
                        ),
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: state,
                          label: 'State',
                          hintText: 'Enter your state',
                          keyBordType: TextInputType.streetAddress,
                        ),
                        AddressFormTextForm(
                          focusNode: focusNode,
                          controller: mobile,
                          label: 'Mobile Number',
                          hintText: 'Enter your mobile number',
                          keyBordType: TextInputType.number,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ButtonSmall(
                          label: "Submit",
                          onPressed: () {
                            // focusNode.dispose();
                            int finalPin = int.parse(pin.text);
                            Provider.of<AddressProvider>(context, listen: false)
                                .addAddress(AddressModel(
                              name: name.text,
                              address: address.text,
                              street: street.text,
                              post: post.text,
                              city: city.text,
                              pin: finalPin,
                              state: state.text,
                              mobile: mobile.text,
                            ));

                            Navigator.pop(context);
                          },
                        )
                      ],
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
