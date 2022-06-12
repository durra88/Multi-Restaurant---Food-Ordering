import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state/cart_state.dart';
import '../../state/main_state.dart';
import '../../strings/cart_string.dart';
import '../../utils/utils.dart';
import 'cart_total_item_widget.dart';

class TotalWidget extends StatelessWidget {
  final MainStateController mainStateController = Get.find();
  final CartStateController controller;
  TotalWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TotalItemWidget(
                text: totalText,
                value: currencyFormat.format(controller.sumCart(
                    mainStateController
                        .selectedRestaurant.value.restaurantId!)),
                isSubTotal: false),
          ],
        ),
      ),
    );
  }
}
