import 'package:flutter/material.dart';
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
}
