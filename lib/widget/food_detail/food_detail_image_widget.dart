
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:order_food/state/cart_state.dart';
import 'package:order_food/state/food_list_state.dart';

import '../../const/const.dart';
import '../../state/food_detail_state.dart';
import '../../state/main_state.dart';
import '../../utils/utils.dart';

class FoodDetailImageWidget extends StatelessWidget {
  const FoodDetailImageWidget({
    Key? key,
    required this.foodListStateController,
    required this.cartStateController,
    required this.mainStateController,
    required this.foodDetailStateController,
  }) : super(key: key);

  final FoodListStateController foodListStateController;
  final CartStateController cartStateController;
  final MainStateController mainStateController;
  final FoodDetailStateController foodDetailStateController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
