import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerContent extends StatelessWidget {
  IconData icon;
  String labelName;
  final VoidCallback? callbackFunction;
  DrawerContent({
    super.key,
    required this.icon,
    required this.labelName,
    this.callbackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: callbackFunction,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              labelName,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
