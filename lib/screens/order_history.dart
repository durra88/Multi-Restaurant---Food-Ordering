import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/const/const.dart';
import 'package:order_food/model/order_model.dart';
import 'package:order_food/state/main_state.dart';
import 'package:order_food/strings/main_strings.dart';
import 'package:order_food/view_model/order_history_vm/order_history_view_model_imp.dart';
import 'package:order_food/widget/order_history/order_history_list_widget.dart';

import '../widget/order_history/order_history_widget.dart';

class OrderHistoryScreen extends StatelessWidget {
  final vm = new OrderHistoryViewModelImp();
  final MainStateController mainStateController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
      appBar: AppBar(
          title: Text(orderHistoryText),
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.cancel),),
          Tab(icon: Icon(Icons.refresh),),
          Tab(icon: Icon(Icons.check),),
        ],),
      ),
      body: TabBarView(
        children: [
          OrderHistoryWidget(vm,mainStateController,ORDER_CANCELEED),
          OrderHistoryWidget(vm,mainStateController,ORDER_PROCESSING),
          OrderHistoryWidget(vm,mainStateController,ORDER_SHIPPED),
        ],
      )
    ),
        ));
  }
}
