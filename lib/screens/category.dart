import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';
import '../state/category_state.dart';
import '../state/main_state.dart';
import '../view_model/catgory_vm/category_viewmodel_imp.dart';
import '../widget/category/category_list_widget.dart';
import '../widget/common/appbar_with_cart_widget.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = CategoryViewModelImp();
    final MainStateController mainStateController = Get.find();
    final CategoryStateController categoryStateController =
        Get.put(CategoryStateController());

    return Scaffold(
      appBar: AppBarWithCartButton(
        title: '${mainStateController.selectedRestaurant.value.name}',
      ),
      body: FutureBuilder(
        future: viewModel.displayCategoryByRestaurntId(
            mainStateController.selectedRestaurant.value.restaurantId!),
        builder: (context, snapshot) {
          log("category----------${snapshot.toString()}");

          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lst = snapshot.data as List<CategoryModel>;

            return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Expanded(
                        child: CartListWidget(
                            lst: lst,
                            categoryStateController: categoryStateController))
                  ],
                ));
          }
        },
      ),
    );
  }
}
