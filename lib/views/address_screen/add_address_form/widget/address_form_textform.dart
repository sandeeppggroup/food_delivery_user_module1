import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddressFormTextForm extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hintText;
  TextInputType keyBordType;
  FocusNode focusNode;
  int length;
  String? Function(String?)? validator;
  AddressFormTextForm(
      {super.key,
      required this.controller,
      required this.label,
      required this.hintText,
      required this.keyBordType,
      required this.focusNode,
      required this.validator,
      required this.length});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
      ),
      child: TextFormField(
        keyboardAppearance: Brightness.dark,
        controller: controller,
        keyboardType: keyBordType,
        maxLength: length,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
          fillColor: Colors.white54,
          filled: true,
          label: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
