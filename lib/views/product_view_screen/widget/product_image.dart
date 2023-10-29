import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductImageContainer extends StatelessWidget {
  String? imageUrl;
  ProductImageContainer({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .4,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 149, 185),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 4),
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 5.0, right: 15.0, top: 10, bottom: 5),
            child: Image.network(imageUrl.toString()),
          ),
        ),
      ),
    );
  }
}
