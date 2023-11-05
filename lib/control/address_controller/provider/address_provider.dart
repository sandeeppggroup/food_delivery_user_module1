import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:user_module/control/address_controller/service/address_service.dart';

class AddressProvider extends ChangeNotifier {
  AddressService addressService = AddressService();

  AddressProvider() {
    getAllAddress();
  }

  Future<void> addAddress(
    String name,
    String address,
    String street,
    String post,
    String city,
    String pin,
    String state,
    String mobile,
  ) async {
    final result = addressService.addAddress(
        name, address, street, post, city, pin, state, mobile);
  }

  Future<void> getAllAddress() async {
    final result = addressService.getAllAddress();
  }
}
