
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/order_model.dart';
import '../../utils/utils.dart';

class OrderHistoryDetailListWidget extends StatelessWidget {
  const OrderHistoryDetailListWidget({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: SizedBox(
        height: 200,
        child: ListView.builder(
            itemCount: orderModel.cartItemList!.length,
            itemBuilder: (context, index) {
              if (orderModel.cartItemList!.length == 0) {
                return Text("empty");
              }
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
                  "quantity:${orderModel.cartItemList![index].quantity == null ? orderModel.cartItemList![index].quantity : ""}";
              if (sizeText.length > 0) infoText += "\nSize: $sizeText";
              if (addonText.length > 0)
                infoText += "\nSize: $addonText";
              return Card(
                elevation: 8.0,
                child: SizedBox(
                  // height: 400,
                  width: double.infinity,
                  child: ListTile(
                    title: Text(
                        orderModel.cartItemList![index].name ?? ""),
                    leading: CachedNetworkImage(
                      imageUrl:
                          orderModel.cartItemList![index].image ?? "",
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
                    isThreeLine: true,
                    subtitle: Text('$infoText'),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
