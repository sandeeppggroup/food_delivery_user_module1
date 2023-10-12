import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog(BuildContext context,
    {required VoidCallback? onPressedFunction, required String massage}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: Text(massage),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: onPressedFunction,
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

void showItemSnackBar(BuildContext context,
    {required String massage, required color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            massage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
