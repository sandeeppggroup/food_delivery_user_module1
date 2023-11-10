import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/core/colors/colors.dart';

class PickupDelivery extends StatelessWidget {
  const PickupDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProviderWatch = context.watch<CartProvider>();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Radio(
          value: 'pickup',
          groupValue: cartProvider.selectedOption,
          onChanged: (value) {
            cartProviderWatch.handleRadioValueChangePickup(value!);
          },
        ),
        SizedBox(
          height: height * .045,
          width: width * 0.35,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              cartProvider.handleRadioValueChangePickup('pickup');
            },
            child: const Text('PickUp'),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: height * .045,
          width: width * 0.35,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              cartProvider.handleRadioValueChangeDelivery('delivery');
            },
            child: const Text('Delivery'),
          ),
        ),
        Radio(
          value: 'delivery',
          groupValue: cartProvider.selectedOption,
          onChanged: (value) {
            cartProviderWatch.handleRadioValueChangeDelivery(value!);
          },
        ),
      ],
    );
  }
}
