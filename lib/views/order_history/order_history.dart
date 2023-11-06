import 'package:flutter/material.dart';
import 'package:user_module/control/order_history/porvider/order_history_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderHistoryProvider orderHistoryProvider = OrderHistoryProvider();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return const Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Date: '),
                  // ${order.isDelivered ? 'Delivered' : 'Not Delivered'}
                  Text('Delivery Status: '),
                  Divider(),
                  Text('Products:'),
                  // for (var product in order.products)
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('${product.qty} x ${product.name}'),
                  //       Text('\$${product.amount.toStringAsFixed(2)}'),
                  //     ],
                  //   ),
                  Divider(),
                  // ${order.totalAmount.toStringAsFixed(2)}
                  Text('Total Amount: \$'),
                  Row(
                    children: [
                      Text('Rating: '),
                      Icon(Icons.star, color: Colors.yellow, size: 24),
                    ],
                  ),
                  // ${order.paymentMode}
                  Text('Payment Mode: '),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}