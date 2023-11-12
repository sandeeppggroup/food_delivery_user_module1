import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/home_control/category_provider/category_provider.dart';
import 'package:user_module/control/home_control/prodcut_provider/product_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/model/home_model/category_model.dart';

class CategoryHomeListView extends StatelessWidget {
  const CategoryHomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: height * 0.16,
      child: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) {
          List<CategoryModel> categories = categoryProvider.categories;
          return ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      categoryProvider.selectCategory(category);

                      Provider.of<ProductProvider>(context, listen: false)
                          .fetchCategoryWiseProduct(category.id, category.name);
                      // categoryProvider.setselectedIndex = index;
                    },
                    highlightColor: const Color.fromARGB(255, 255, 179, 204),
                    borderRadius: BorderRadius.circular(15),
                    child: categories.isEmpty
                        ? const Text(
                            'Oops! Something went wrong.  \nplease check your network connection')
                        : Container(
                            height: height * 0.11,
                            width: width * 0.33,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: categoryProvider.categoryName ==
                                            category.name
                                        ? const Color.fromARGB(
                                            255, 106, 170, 255)
                                        : const Color.fromARGB(
                                            255, 255, 179, 204)),
                                boxShadow: [
                                  BoxShadow(
                                    color: categoryProvider.categoryName ==
                                            category.name
                                        ? const Color.fromARGB(
                                            255, 106, 170, 255)
                                        : const Color.fromARGB(
                                            255, 255, 179, 204),
                                    blurRadius: 6,
                                    offset: const Offset(6, 4),
                                  )
                                ],
                                color: userAppBar,
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child:
                                        Image.network(category.image.imageUrl),
                                  ),
                                  Text(
                                    category.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: buttonColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    width: width * 0.06,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
