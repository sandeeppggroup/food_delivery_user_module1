import 'package:flutter/material.dart';
import 'package:user_module/control/order_history/service/order_history_service.dart';

class OrderHistoryProvider extends ChangeNotifier {
  OrderHistoryService orderHistoryService = OrderHistoryService();
  OrderHistoryProvider() {
    getAllOrders();
  }

  Future<dynamic> getAllOrders() async {
    final result = await orderHistoryService.getAllOrders();
  }
}
