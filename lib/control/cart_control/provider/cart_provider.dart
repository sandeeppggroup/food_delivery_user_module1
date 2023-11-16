// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:user_module/control/cart_control/service/cart_service.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/cart_model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  CartService cartService = CartService();

  String? selectedOption;
  List<CartItem> _cartProducts = [];

  CartProvider() {
    fetchCartData();
  }

  List<CartItem> get cartProducts => _cartProducts;

  void handleRadioValueChangePickup(dynamic value) {
    log('value : $value');
    selectedOption = value;
    log('Selected option : ${selectedOption.toString()}');
    notifyListeners();
  }

  void handleRadioValueChangeDelivery(dynamic value) {
    log('value : $value');
    selectedOption = value;
    log('Selected option : ${selectedOption.toString()}');
    notifyListeners();
  }

  void clearAllCarts() {
    _cartProducts.clear();
  }

  Future<void> fetchCartData() async {
    try {
      final result = await cartService.getAllCartItems();
      log('in fetchcartdarta ${result.toString()}');
      if (result != false) {
        _cartProducts = result;
      } else {
        _cartProducts.clear();
      }

      notifyListeners();
    } catch (e) {
      log('Error fetching cart data : $e');
    }
  }

  Future<void> increaseOrDecreaseQuantity(
      String quantity, String productId) async {
    log('log in cart provider productId : $productId  , $quantity');
    final result =
        await cartService.increaseOrDecreaseQuantityInCart(quantity, productId);

    if (result == true) {
      fetchCartData();
    } else {
      return;
    }
  }
}
