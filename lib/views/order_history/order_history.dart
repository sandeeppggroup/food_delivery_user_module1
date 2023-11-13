import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/order_history/porvider/order_history_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/order_history_model/order_history_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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

              String orderDate = dateTimeFormat(orderData.orderDate.toString());
              String? pickupDate =
                  dateFormatPickup(orderData.pickupDate.toString());

              String? pickupTime =
                  timeFormatPickup(orderData.pickupTime.toString());

              return Card(
                color: userAppBar,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date & Time : $orderDate',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      // ${order.isDelivered ? 'Delivered' : 'Not Delivered'}
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          orderData.orderStatus != 'delivered' &&
                                  orderData.orderStatus != 'cancelled'
                              ? SizedBox(
                                  height: height * 0.035,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        orderHistoryprovider.cancelOrder(
                                            orderData.id.toString());
                                      },
                                      child: const Text('Cancel Order')),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),

                      pickupDate != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(
                                  thickness: 2,
                                ),
                                const Center(
                                  child: Text(
                                    'Take Away',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  'Pickup Date  : $pickupDate',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  'Pickup Time : $pickupTime',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                              ],
                            )
                          : const Divider(
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Payment Mode: ${orderData.payment}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(
                              'Total Amount :  ₹${orderData.totalAmount.toString()}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Text(
                        'Payment Status  :  ${orderData.paymentStatus}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
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

  String dateTimeFormat(String data) {
    DateTime originalDate = DateTime.parse(data);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy : HH-mm');
    String orderDate = dateFormat.format(originalDate);
    return orderDate;
  }

  String? dateFormatPickup(String data) {
    if (data != 'null') {
      DateTime originalDate = DateTime.parse(data);
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      String orderDate = dateFormat.format(originalDate);
      return orderDate;
    }
    return null;
  }

  String? timeFormatPickup(String data) {
    if (data != 'null') {
      String receivedTimeString = data;
      String hour = receivedTimeString.split('(')[1].split(':')[0];
      String minute = receivedTimeString.split(':')[1].split(')')[0];

      String formattedTime = '$hour:${minute.padLeft(2, '0')}';
      return formattedTime;
    }
    return null;
  }
}
