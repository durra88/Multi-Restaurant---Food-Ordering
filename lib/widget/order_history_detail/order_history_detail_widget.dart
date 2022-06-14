
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/order_model.dart';
import '../../strings/cart_string.dart';
import '../../strings/order_history_string.dart';
import '../../utils/utils.dart';

class OrderHistoryDetailWidget extends StatelessWidget {
  const OrderHistoryDetailWidget({
    Key? key,
    required this.orderModel,
    required this.chipBackgroundColor,
    required this.chipForegroundColor,
    required this.noSymbolUSFormat,
  }) : super(key: key);

  final OrderModel orderModel;
  final MaterialColor chipBackgroundColor;
  final Color chipForegroundColor;
  final NumberFormat noSymbolUSFormat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(8),
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${orderModel.shippingAddress}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
              SizedBox(
                width: 20,
              )
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
    );
  }
}
