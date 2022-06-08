import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:order_food/state/order_history_state.dart';
import 'package:order_food/strings/cart_string.dart';
import 'package:order_food/strings/order_history_string.dart';
import 'package:order_food/utils/utils.dart';

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
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  //height: 800,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${orderModel.userName!.toUpperCase()}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              '${orderModel.shippingAddress}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${orderModel.userPhone!}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Chip(
                                backgroundColor: chipBackgroundColor,
                                label: Text(
                                  '${convertStatus(orderModel.orderStatus!)}',
                                  style: TextStyle(color: chipForegroundColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              totalText,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${noSymbolUSFormat.format(orderModel.totalPayment!)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              discountText,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${orderModel.discount!}%',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            finalText,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          Expanded(
                            child: Text(
                              '\$${noSymbolUSFormat.format(orderModel.finalPayment!)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: orderModel.cartItemList!.length,
                    itemBuilder: (context, index) {
                      var sizeText =
                          orderModel.cartItemList![index].size!.length > 0
                              ? orderModel.cartItemList![index].size![0].name!
                              : "";
                      var addonText =
                          orderModel.cartItemList![index].addon!.length > 0
                              ? convertAddonToText(
                                  orderModel.cartItemList![index].addon!)
                              : "";
                      var infoText =
                          "quantity:${orderModel.cartItemList![index].quantity!}";
                      if (sizeText.length > 0) infoText += "\nSize: $sizeText";
                      if (addonText.length > 0)
                        infoText += "\nSize: $addonText";
                      return Card(
                        elevation: 8.0,
                        child: ListTile(
                          title: Text(orderModel.cartItemList![index].name!),
                          leading: SizedBox(
                            height: 200,
                            child: CachedNetworkImage(
                              imageUrl: orderModel.cartItemList![index].image!,
                              imageBuilder: (context, provider) => CircleAvatar(
                                backgroundImage: provider,
                              ),
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, err) => Center(
                                child: Icon(Icons.image),
                              ),
                            ),
                          ),
                          isThreeLine: true,
                          subtitle: Text('$infoText'),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
