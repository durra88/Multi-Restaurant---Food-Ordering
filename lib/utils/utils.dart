import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/addon_model.dart';

final currencyFormat = NumberFormat.simpleCurrency();

double foodDetailsImageAreaSize(BuildContext context) {
  return MediaQuery.of(context).size.height / 3;
}

double calculateFinalPayement(double subTotal, double discount) {
  return subTotal - (subTotal * (discount / 100));
}

int createOrderNumber(int orginal) {
  return orginal + new Random().nextInt(1000);
}

String convertToDate(int date) => DateFormat('dd-mm-yyyy HH:mm')
    .format(DateTime.fromMillisecondsSinceEpoch(date));
String convertStatus(int status) => status == 0
    ? 'Placed'
    : status == 1
        ? 'Shipping'
        : status == 2
            ? 'Shipped'
            : 'Cancelled';
MaterialColor convertStatusToColor(int orderStatus) => orderStatus == -1
    ? Colors.red
    : orderStatus == 0
        ? Colors.blue
        : orderStatus == 1
            ? Colors.yellow
            : Colors.green;
String convertAddonToText(List<AddonModel> addon) {
  var result = "";
  addon.map((e) => result += "${e.name},");
  return result.length > 0 ? result.substring(0, result.length - 1) : result;
}
