import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:user_module/control/address_controller/service/address_service.dart';
import 'package:user_module/model/address_model/address_model.dart';

class AddressProvider extends ChangeNotifier {
  AddressService addressService = AddressService();

  List<AddressModel> _addressList = [];
  late AddressModel _selectedAddress;

  AddressProvider() {
    _selectedAddress = AddressModel(
      name: '',
      address: '',
      street: '',
      post: '',
      city: '',
      pin: 0,
      state: '',
      mobile: '',
    );
    getAllAddress();
  }

  List<AddressModel> get addressList => _addressList;
  AddressModel get selectedAddress => _selectedAddress;

  void toggleAddressSelection(AddressModel address) {
    _selectedAddress = address;
    log(_selectedAddress.name);
    notifyListeners();
  }

  AddressModel getSelectedAddress() {
    return _selectedAddress;
  }

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
