import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../state/cart_state.dart';
import '../state/category_state.dart';
import '../state/food_detail_state.dart';
import '../state/food_list_state.dart';
import '../state/main_state.dart';
import '../utils/utils.dart';
import '../widget/food_detail/food_detail_addon_widget.dart';
import '../widget/food_detail/food_detail_description_widget.dart';
import '../widget/food_detail/food_detail_image_widget.dart';
import '../widget/food_detail/food_detail_name_widget.dart';
import '../widget/food_detail/food_detail_size_widget.dart';

class FoodDetailScreen extends StatelessWidget {
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController = Get.find();
  final MainStateController mainStateController = Get.find();

  final FoodDetailStateController foodDetailStateController =
      Get.put(FoodDetailStateController());
  final CartStateController cartStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  '${foodListStateController.selectedFood.value.name}',
                  style: GoogleFonts.jetBrainsMono(color: Colors.black),
                ),
                elevation: 10,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                foregroundColor: Colors.black,
                bottom: PreferredSize(
                  preferredSize: Size.square(foodDetailsImageAreaSize(context)),
                  child: FoodDetailImageWidget(
                      foodListStateController: foodListStateController,
                      cartStateController: cartStateController,
                      mainStateController: mainStateController,
                      foodDetailStateController: foodDetailStateController),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FoodDetailNameWidget(
                      foodListStateController: foodListStateController,
                      foodDetailStateController: foodDetailStateController),
                  FoodDetailDescriptionWidget(
                      foodListStateController: foodListStateController),
                  foodListStateController.selectedFood.value.size!.length > 0
                      ? FoodDetailSizeWidget(
                          foodListStateController: foodListStateController,
                          foodDetailStateController: foodDetailStateController)
                      : Container(),
                  FoodDetailAddon(
                      foodListStateController: foodListStateController,
                      foodDetailStateController: foodDetailStateController)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
