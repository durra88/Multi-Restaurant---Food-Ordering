import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/model/size_model.dart';
import 'package:order_food/state/food_detail_state.dart';
import 'package:order_food/state/food_list_state.dart';
import 'package:order_food/strings/food_detail_string.dart';

class FoodDetailSizeWidget extends StatelessWidget {
  final FoodDetailStateController foodDetailStateController;
  final FoodListStateController foodListStateController;
  const FoodDetailSizeWidget(
      {Key? key,
      required this.foodListStateController,
      required this.foodDetailStateController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return foodListStateController.selectedFood.value.size!.length > 0
        ? Card(
            elevation: 12,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => ExpansionTile(
                      title: Text(
                        sizeText,
                        style: GoogleFonts.jetBrainsMono(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      children: foodListStateController.selectedFood.value.size!
                          .map((e) => RadioListTile<SizeModel>(
                              title: Text(e.name!),
                              value: e,
                              groupValue:
                                  foodDetailStateController.selectedSize.value,
                              onChanged: (value) => foodDetailStateController
                                  .selectedSize.value = value!))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}