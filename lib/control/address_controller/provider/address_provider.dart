// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_module/control/address_controller/service/address_service.dart';
import 'package:user_module/core/colors/colors.dart';
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

  void getFirstAddress() async {
    await getAllAddress();
    if (_addressList.isNotEmpty) {
      for (int i = 0; i < 1; i++) {
        AddressModel selectedAddress1 = _addressList[i];
        _selectedAddress = selectedAddress1;
        log('Get first address: ${selectedAddress1.name}');
        // log('order id : ${_selectedAddress.id}');
        notifyListeners();
      }
    } else {
      return;
    }
  }

  void toggleAddressSelection(AddressModel address) {
    _selectedAddress = address;
    log(_selectedAddress.name);
    notifyListeners();
  }

  AddressModel getSelectedAddress() {
    return _selectedAddress;
  }

  Future<void> addAddress(
      AddressModel addressModel, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: buttonColor,
            color: Colors.amber,
            strokeWidth: 6,
            strokeAlign: 3,
          ),
        );
      },
    );
    final result = await addressService.addAddress(addressModel);
    log('message in address Provider : ${result.toString()}');
    if (result == true) {
      getAllAddress();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/address_screen');
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: buttonColor,
        fontSize: 15,
      );
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/address_screen');
      return;
    }
  }

  Future<void> getAllAddress() async {
    _addressList = await addressService.getAllAddress();
    log('in Address provider :  $_addressList');

    notifyListeners();
  }

  Future<void> deleteAddress(String addressId, BuildContext context) async {
    final result = await addressService.deleteAddress(addressId);
    if (result == true) {
      getAllAddress();
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Deleted address successfully',
        backgroundColor: buttonColor,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: buttonColor,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pop(context);
    }
  }
}
