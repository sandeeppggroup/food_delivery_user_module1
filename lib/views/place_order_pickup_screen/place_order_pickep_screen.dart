import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:user_module/control/place_order_pickup/pickup_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/button1.dart';
import 'package:user_module/widget/logo.dart';
import 'package:user_module/widget/payment_option.dart';

// ignore: must_be_immutable
class PlaceOrderPickup extends StatefulWidget {
  int? cartSum;

  PlaceOrderPickup({super.key, this.cartSum});

  @override
  State<PlaceOrderPickup> createState() => _PlaceOrderPickupState();
}

class _PlaceOrderPickupState extends State<PlaceOrderPickup> {
  @override
  Widget build(BuildContext context) {
    final pickupProvider = Provider.of<PickupProvider>(context, listen: false);
    final pickupProviderWatch = context.watch<PickupProvider>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.08,
          ),
          Logo(height: height * 0.13),
          SizedBox(
            height: height * 0.02,
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
                    child: SizedBox(
                      height: height * .045,
                      width: width * 0.35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('PickUp'),
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white, thickness: 2),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Selected date :',
                          style: TextStyle(
                              fontSize: 18,
                              color: buttonColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '     ${DateFormat('dd-MM-yyyy').format(pickupProviderWatch.selectedDay)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 2),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 8),
                    child: Container(
                      color: Colors.white,
                      child: TableCalendar(
                        focusedDay: pickupProviderWatch.selectedDay,
                        firstDay: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        // Set it to the start of the previous month
                        lastDay: DateTime(DateTime.now().year,
                            DateTime.now().month + 10, DateTime.now().day),
                        // Set it to the end of the next month
                        calendarFormat: CalendarFormat.month,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month'
                        },
                        rowHeight: 40,
                        onDaySelected: (selectedDay, focusedDay) {
                          pickupProvider.selectDate(selectedDay, focusedDay);
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(pickupProvider.selectedDay, date);
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Selected time :',
                          style: TextStyle(
                              fontSize: 18,
                              color: buttonColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        pickupProvider.selectedTime.format(context),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          pickupProvider.selectTime(context);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          size: 35,
                          color: buttonColor,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    height: height * 0.13,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 95.0,
                            top: 35,
                          ),
                          child: ButtonBig(
                            label: '₹${widget.cartSum}            Place Order',
                            onPressed: () {
                              bottomSheetPaymentOption(
                                  context, widget.cartSum!);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
