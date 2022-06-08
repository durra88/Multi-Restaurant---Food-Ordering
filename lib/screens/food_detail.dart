import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/const/const.dart';
import 'package:order_food/model/size_model.dart';
import 'package:order_food/state/cart_state.dart';
import 'package:order_food/state/category_state.dart';
import 'package:order_food/state/food_detail_state.dart';
import 'package:order_food/state/food_list_state.dart';
import 'package:order_food/state/main_state.dart';
import 'package:order_food/strings/food_detail_string.dart';
import 'package:order_food/utils/utils.dart';

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
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: foodDetailsImageAreaSize(context) * 0.9,
                        child: Hero(
                          tag: foodListStateController.selectedFood.value.name!,
                          child: CachedNetworkImage(
                            imageUrl: foodListStateController
                                .selectedFood.value.image!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.image),
                            ),
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.8, 1.0),
                        heightFactor: 0.5,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FloatingActionButton(
                                heroTag: FAB_FAV_TAG,
                                onPressed: () {},
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                ),
                                elevation: 10,
                                backgroundColor: Colors.white,
                              ),
                              FloatingActionButton(
                                heroTag: FAB_CART_TAG,
                                onPressed: () => cartStateController.addToCart(
                                    foodListStateController.selectedFood.value,
                                    mainStateController
                                        .selectedRestaurant.value.restaurantId!,
                                    quantity: foodDetailStateController
                                        .quantity.value),
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.black,
                                ),
                                elevation: 10,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
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
                  Card(
                    elevation: 12,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${foodListStateController.selectedFood.value.name}',
                            style: GoogleFonts.jetBrainsMono(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${foodListStateController.selectedFood.value.price}',
                                style: GoogleFonts.jetBrainsMono(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                ),
                              ),
                              Obx(() => ElegantNumberButton(
                                  initialValue:
                                      foodDetailStateController.quantity.value,
                                  minValue: 1,
                                  maxValue: 100,
                                  color: Colors.amber,
                                  onChanged: (value) {
                                    print('clicked $value');
                                    foodDetailStateController.quantity.value =
                                        value.toInt();
                                  },
                                  decimalPlaces: 0)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 12,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemBuilder: (context, _) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              },
                              onRatingUpdate: (value) {}),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${foodListStateController.selectedFood.value.description}',
                            style: GoogleFonts.jetBrainsMono(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  foodListStateController.selectedFood.value.size!.length > 0
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
                                    children: foodListStateController
                                        .selectedFood.value.size!
                                        .map((e) => RadioListTile<SizeModel>(
                                            title: Text(e.name!),
                                            value: e,
                                            groupValue:
                                                foodDetailStateController
                                                    .selectedSize.value,
                                            onChanged: (value) =>
                                                foodDetailStateController
                                                    .selectedSize
                                                    .value = value!))
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Card(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
