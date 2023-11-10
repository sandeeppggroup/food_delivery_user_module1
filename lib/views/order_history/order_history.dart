import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/order_history/porvider/order_history_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/order_history_model/order_history_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Provider.of<OrderHistoryProvider>(context, listen: false).getAllOrders();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, orderHistoryprovider, _) {
          List<OrderData> orderDatas = orderHistoryprovider.orderHistoryList;
          log('orderDatas length : ${orderDatas.length}');
          return ListView.builder(
            itemCount: orderDatas.length,
            itemBuilder: (context, index) {
              OrderData orderData = orderDatas[index];
              String originalDateString = orderData.orderDate.toString();
              DateTime originalDate = DateTime.parse(originalDateString);
              DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
              String orderDate = dateFormat.format(originalDate);
              return Card(
                color: userAppBar,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date: $orderDate',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      // ${order.isDelivered ? 'Delivered' : 'Not Delivered'}
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              ' ${orderData.orderStatus} ',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Payment Status  :  ${orderData.paymentStatus}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const Text(
                        'Products :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),

                      for (var product in orderData.product)
                        Column(
                          children: [
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          '*${product.quantity.toString()} ',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Text('       ${product.name}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text('₹${product.price.toString()}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      const Divider(
                        thickness: 2,
                      ),
                      // ${order.totalAmount.toStringAsFixed(2)}
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Text('Rating: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.star, color: Colors.yellow, size: 24),
                            ],
                          ),
                          Text(
                              'Total Amount :  ₹${orderData.totalAmount.toString()}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),

                      // ${order.paymentMode}
                      Text('Payment Mode: ${orderData.payment}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
