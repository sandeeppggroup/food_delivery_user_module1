import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:user_module/control/address_controller/service/address_service.dart';
import 'package:user_module/model/address_model/address_model.dart';

class AddressProvider extends ChangeNotifier {
  AddressService addressService = AddressService();

  List<AddressModel> _addressList = [];

  // List<bool> selectedAddress = List.generate(addresses.length, (index) => false);

  AddressProvider() {
    getAllAddress();
  }

  List<AddressModel> get addressList => _addressList;

  void handleCheckboxChanged(int index, int value) {}

  Future<void> addAddress(AddressModel addressModel) async {
    final result = await addressService.addAddress(addressModel);
    log('message in address Provider : ${result.toString()}');
    if (result == true) {
      getAllAddress();
    } else {
      return;
    }
  }

  Future<void> getAllAddress() async {
    _addressList = await addressService.getAllAddress();
    log('in Address provider :  $_addressList');

    notifyListeners();
  }
}
