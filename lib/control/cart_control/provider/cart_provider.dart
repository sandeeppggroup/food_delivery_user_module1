import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:user_module/control/cart_control/service/cart_service.dart';
import 'package:user_module/model/cart_model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  CartService cartService = CartService();

  dynamic selectedOption;
  List<CartItem> _cartProducts = [];

  CartProvider() {
    fetchCartData();
  }

  List<CartItem> get cartProducts => _cartProducts;

  void handleRadioValueChangePickup(dynamic value) {
    selectedOption = value;
    notifyListeners();
  }

  void handleRadioValueChangeDelivery(dynamic value) {
    selectedOption = value;
    notifyListeners();
  }

  Future<void> fetchCartData() async {
    try {
      _cartProducts = await cartService.getAllCartItems();

      notifyListeners();
    } catch (e) {
      log('Error fetching cart data : $e');
    }
  }
}
