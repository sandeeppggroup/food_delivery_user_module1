import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/core/colors/colors.dart';

// ignore: must_be_immutable
class HeadingAndSearchBar extends StatelessWidget {
  FocusNode? focusNode;
  HeadingAndSearchBar({super.key, required this.focusNode});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Your Taste',
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          'Food You Love',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          height: height * 0.055,
          width: width * 0.85,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 190, 189, 189),
                blurRadius: 1,
                offset: Offset(8, 8),
              )
            ],
            color: userAppBar,
            // border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 65.0),
            child: SizedBox(
              height: 38,
              width: 250,
              child: TextFormField(
                onChanged: (value) async {
                  Future.delayed(const Duration(seconds: 1));
                  log(value.toString());
                  String searchUrl = value.toString();
                  productProvider.fetchSortCategoryAndPriceWiseProduct(
                      searchUrl: searchUrl);
                },
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Food Here Foody',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    size: 50,
                    color: Color.fromARGB(179, 190, 192, 192),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
