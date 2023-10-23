import 'dart:developer';

import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  dynamic selectedOption;

  void handleRadioValueChangePickup(dynamic value) {
    selectedOption = value;
    notifyListeners();
  }

  void handleRadioValueChangeDelivery(dynamic value) {
    selectedOption = value;
    notifyListeners();
  }
}
