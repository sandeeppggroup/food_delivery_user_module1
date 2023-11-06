import 'package:flutter/material.dart';
import 'package:user_module/core/colors/colors.dart';

// ignore: must_be_immutable
class AddressFormTextForm extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hintText;
  TextInputType keyBordType;
  FocusNode focusNode;
  AddressFormTextForm({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.keyBordType,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 8, bottom: 8),
      child: SizedBox(
        height: height * 0.06,
        child: TextFormField(
          keyboardAppearance: Brightness.dark,
          controller: controller,
          keyboardType: keyBordType,
          decoration: InputDecoration(
            fillColor: Colors.white54,
            filled: true,
            label: Text(
              label,
              style: const TextStyle(fontSize: 18, color: buttonColor),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
