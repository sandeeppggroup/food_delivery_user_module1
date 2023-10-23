import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/views/user_home_page/widget/category_listview.dart';
import 'package:user_module/views/user_home_page/widget/product_listview.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final categoryProviderWatch = context.watch<CategoryProvider>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Stack(
              children: [
                SizedBox(
                  width: width * 0.21,
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      size: 52,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  height: 15,
                  width: 10,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/drawer_user_image1.png'),
                    ),
                  ),
                  // child: Image.asset('assets/images/burger_cola_frenchfries.png'),
                ),
              );
            },
          ),
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Your Taste',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'Food You Love',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              productProvider
                                  .fetchSortCategoryAndPriceWiseProduct(
                                      searchUrl: searchUrl);
                            },
                            focusNode: _focusNode,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Food Here Foody',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 19),
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
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: CategoryHomeListView(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            productProvider.fetchAllProducts();
                            categoryProvider.setCategoryName = null;
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text('All products'),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Price Sort :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              dynamic categoryName =
                                  categoryProvider.categoryName;
                              String urlLowToHigh = 'lowToHigh';
                              String? categoryId = categoryProvider.categoryId;
                              if (categoryName != null) {
                                productProvider
                                    .fetchSortCategoryAndPriceWiseProduct(
                                        categoryId: categoryId!,
                                        sorturl: urlLowToHigh);
                              } else {
                                productProvider
                                    .fetchSortCategoryAndPriceWiseProduct(
                                        sorturl: urlLowToHigh);
                              }
                            },
                            child: const Icon(
                              Icons.arrow_upward,
                              size: 25,
                            )),
                        TextButton(
                          onPressed: () {
                            dynamic categoryName =
                                categoryProvider.categoryName;
                            String urlHighToLow = 'highToLow';
                            String? categoryid = categoryProvider.categoryId;

                            if (categoryName != null) {
                              productProvider
                                  .fetchSortCategoryAndPriceWiseProduct(
                                      categoryId: categoryid!,
                                      sorturl: urlHighToLow);
                            } else {
                              productProvider
                                  .fetchSortCategoryAndPriceWiseProduct(
                                      sorturl: urlHighToLow);
                            }
                          },
                          child: const Icon(
                            Icons.arrow_downward,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        Provider.of<CategoryProvider>(context).categoryName !=
                                null
                            ? categoryProviderWatch.categoryName.toString()
                            : 'All Products',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: ProductHomeListView(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 310),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 21,
                    backgroundColor: buttonColor,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart_screen');
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
