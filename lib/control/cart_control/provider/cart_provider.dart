import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:user_module/control/cart_control/service/cart_service.dart';
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
    selectedOption = value;
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
      _cartProducts = await cartService.getAllCartItems();
      log('in fetchcartdarta $_cartProducts');

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
