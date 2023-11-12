// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/control/product_view_control/service/product_view_service.dart';
import 'package:user_module/widget/show_dialog.dart';

class ProductViewProvider extends ChangeNotifier {
  String _quantity = '1';
  dynamic _totalPrice;

  ProductViewService productViewService = ProductViewService();

  ProductViewProvider() {
    initialQuantity = '1';
    notifyListeners();
  }

  String get quantity => _quantity;
  String? get totalPrice => _totalPrice;

  set initialQuantity(String value) {
    _quantity = value;
    log('initialQuantity : $value');
    notifyListeners();
  }

  set initialPrize(dynamic prize) {
    _totalPrice = prize;
    log('initialQuantity : $prize');
    notifyListeners();
  }

  void incrementQuantity() {
    int value = int.parse(_quantity);
    value++;
    _quantity = value.toString();
    log('incrementQuantity  :  $_quantity');
    notifyListeners();
  }

  void decrementQuantity() {
    int value = int.parse(_quantity);
    if (value <= 1) {
      return;
    }
    value--;
    _quantity = value.toString();
    log('decrementQuantity  :  $_quantity');
    notifyListeners();
  }

  void calculateTotalPrice(String price) {
    log('calulate : ${price.toString()}');
    num intPrice = num.parse(price);
    num intQty = int.parse(_quantity);
    num totalPrice = intQty * intPrice;
    _totalPrice = totalPrice.toString();
    notifyListeners();
  }

  Future<void> addToCart(String productId, BuildContext context) async {
    int quantity = int.parse(_quantity);
    log('log in productview provider productId : $productId  , $quantity');
    dynamic result = await productViewService.addToCart(productId, quantity);
    if (result == true) {
      showItemSnackBar(context,
          massage: 'Item added to cart successfully', color: Colors.green);

      Provider.of<ProductViewProvider>(context, listen: false).initialQuantity =
          '1';

      Provider.of<ProductViewProvider>(context, listen: false).initialPrize =
          null;

      Provider.of<CartProvider>(context, listen: false).fetchCartData();

      Navigator.pushReplacementNamed(context, '/cart_screen');
    } else {
      showItemSnackBar(context,
          massage: 'something went wrong', color: Colors.red);
      return;
    }
  }

  Future<bool> addToCartFromHome(String productId) async {
    int quantity = int.parse(_quantity);
    log('log in productview provider productId : $productId  , $quantity');
    dynamic result = await productViewService.addToCart(productId, quantity);
    return result;
  }
}
