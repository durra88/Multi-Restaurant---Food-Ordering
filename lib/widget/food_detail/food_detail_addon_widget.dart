
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state/food_detail_state.dart';
import '../../state/food_list_state.dart';
import '../../strings/food_detail_string.dart';

class FoodDetailAddon extends StatelessWidget {
  const FoodDetailAddon({
    Key? key,
    required this.foodListStateController,
    required this.foodDetailStateController,
  }) : super(key: key);

  final FoodListStateController foodListStateController;
  final FoodDetailStateController foodDetailStateController;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  addonText,
                  style: GoogleFonts.jetBrainsMono(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                children: [
                  Wrap(
                    children: foodListStateController
                        .selectedFood.value.addon!
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChoiceChip(
                              label: Text(e.name!),
                              selected: foodDetailStateController
                                  .selectedAddon
                                  .contains(e),
                              selectedColor: Colors.yellow,
                              onSelected: (selected) => selected
                                  ? foodDetailStateController
                                      .selectedAddon
                                      .add(e)
                                  : foodDetailStateController
                                      .selectedAddon
                                      .remove(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
