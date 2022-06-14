import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:order_food/model/order_model.dart';
import '../state/order_history_state.dart';
import '../strings/cart_string.dart';
import '../strings/order_history_string.dart';
import '../utils/utils.dart';
import '../widget/order_history_detail/order_history_detail_list_widget.dart';
import '../widget/order_history_detail/order_history_detail_widget.dart';

class OrderViewDetailScreen extends StatelessWidget {
  final OrderHistoryController orderHistoryController = Get.find();
  final noSymbolUSFormat = new NumberFormat.currency(locale: "en_US");

  @override
  Widget build(BuildContext context) {
    var orderModel = orderHistoryController.selectedOrder.value;
    var chipBackgroundColor = convertStatusToColor(orderModel.orderStatus!);
    var chipForegroundColor = chipBackgroundColor.computeLuminance() < 0.5
        ? Colors.white
        : Colors.black;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order ${orderModel.orderNumber}'),
          actions: [
            (orderModel.orderStatus == 0 || orderModel.orderStatus == 1)
                ? InkWell(
                    child: Icon(Icons.clear),
                    onTap: () {
                      print('Cancel Order');
                    })
                : Container()
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderHistoryDetailWidget(orderModel: orderModel, chipBackgroundColor: chipBackgroundColor, chipForegroundColor: chipForegroundColor, noSymbolUSFormat: noSymbolUSFormat),
            SizedBox(
              height: 10,
            ),
            OrderHistoryDetailListWidget(orderModel: orderModel)
          ],
        ),
      ),
    );
  }
}
