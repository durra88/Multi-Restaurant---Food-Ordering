import 'dart:developer';

import 'package:flutter/material.dart';

import '../../state/main_state.dart';
import '../../strings/order_history_string.dart';
import '../../view_model/order_history_vm/order_history_view_model_imp.dart';
import 'order_history_list_widget.dart';

class OrderHistoryWidget extends StatelessWidget {
  late final OrderHistoryViewModelImp vm;
  late final MainStateController mainStateController;
  late final String orderStatusMode;
  OrderHistoryWidget(this.vm, this.mainStateController, this.orderStatusMode);

  @override
  Widget build(BuildContext context) {
    var lst;
    return FutureBuilder(
        future: vm.getUserHistory(
            mainStateController.selectedRestaurant.value.restaurantId!,
            orderStatusMode),
        builder: (context, snapshot) {
          log("-------------${snapshot.toString()}");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Text("data is null"),
            );
          }

          lst = snapshot.data;
          if (lst.length == 0) {
         //   print(               "lengths***************************************************${lst.length}");
            return Center(
              child: Text(emptyText),
            );
          }

          //  print("lengths***************************************************${lst.toString().length}");
          return OrderHistoryListWidget(
            listOrder: lst,
          );
        });
  }
}
