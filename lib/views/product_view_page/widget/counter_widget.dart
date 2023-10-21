import 'package:flutter/material.dart';
import 'package:user_module/core/colors/colors.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.045,
      width: width * 0.3,
      decoration: BoxDecoration(
          color: userAppBar,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 230, 39, 99),
              blurRadius: 7,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: buttonColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: height * 0.039,
                width: width * 0.08,
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(7)),
                child: const Center(
                  child: Text(
                    '-',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: buttonColor),
                  ),
                ),
              ),
            ),
          ),
          const Text(
            '2',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: height * 0.039,
                width: width * 0.08,
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(7)),
                child: const Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: buttonColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
