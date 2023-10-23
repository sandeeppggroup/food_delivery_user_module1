import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/cart_control/provider/cart_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/cart_page/widget/cart_counter.dart';
import 'package:user_module/widget/logo.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartProviderWatch = context.watch<CartProvider>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * .07,
            ),
            Logo(height: height * .13),
            SizedBox(
              height: height * .03,
            ),
            Container(
              height: height * .7495,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: userAppBar,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'pickup',
                          groupValue: cartProvider.selectedOption,
                          onChanged: (value) {
                            cartProviderWatch
                                .handleRadioValueChangePickup(value!);
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
                              cartProvider
                                  .handleRadioValueChangePickup('pickup');
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
                              cartProvider
                                  .handleRadioValueChangeDelivery('delivery');
                            },
                            child: const Text('Delivery'),
                          ),
                        ),
                        Radio(
                          value: 'delivery',
                          groupValue: cartProvider.selectedOption,
                          onChanged: (value) {
                            cartProviderWatch
                                .handleRadioValueChangeDelivery(value!);
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1.5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Items Added',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1.5,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height * 0.45,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0,
                                    color: userAppBar,
                                    child: ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: Container(
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Image.asset(
                                              'assets/images/burger_cola_frenchfries1.png'),
                                        ),
                                      ),
                                      title: const Text(
                                        'burger',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Text('₹120'),
                                      trailing: Column(
                                        children: [
                                          CounterWidgetCartPage(price: '22'),
                                          const Text(
                                            '₹120',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.15,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 0),
                              blurRadius: 9,
                              spreadRadius: 0)
                        ],
                        color: Color.fromARGB(255, 228, 245, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: buttonColor,
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 21,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              const Text(
                                '1 ITEM ADDED',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: height * .04,
                                width: width * 0.24,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: buttonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Home'),
                                ),
                              ),
                              SizedBox(
                                height: height * .04,
                                width: width * 0.24,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: buttonColor),
                                  onPressed: () {},
                                  child: const Text('Next'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
