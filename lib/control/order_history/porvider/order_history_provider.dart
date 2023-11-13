// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_module/control/order_history/service/order_history_service.dart';
import 'package:user_module/model/order_history_model/order_history_model.dart';

class OrderHistoryProvider extends ChangeNotifier {
  OrderHistoryService orderHistoryService = OrderHistoryService();
  List<OrderData> _orderHistoryList = [];

  OrderHistoryProvider() {
    getAllOrders();
    notifyListeners();
  }

  List<OrderData> get orderHistoryList => _orderHistoryList;

  Future<void> getAllOrders() async {
    final result = await orderHistoryService.getAllOrders();
    if (result != false) {
      _orderHistoryList = result;
      notifyListeners();
    } else {
      _orderHistoryList.clear();
    }

    notifyListeners();
  }

  Future<void> cancelOrder(String orderId, BuildContext context) async {
    final result = await orderHistoryService.cancelOrder(orderId);
    if (result == true) {
      Fluttertoast.showToast(
        msg: 'Order Cancelled',
        fontSize: 15,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pop(context);
      Navigator.pop(context);
      getAllOrders();
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        fontSize: 15,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
