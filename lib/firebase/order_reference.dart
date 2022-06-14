import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../const/const.dart';
import '../model/order_model.dart';

Future<bool> writeOrderToFirebase(OrderModel orderModel) async {
  try {
    await FirebaseDatabase.instance
        .ref()
        .child(RESTAURANT_REF)
        .child(orderModel.restaurantId!)
        .child(ORDER_REF)
        .child(orderModel.orderNumber!)
        .set(orderModel.toJson());

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<List<OrderModel>> getUserOrdersByRestaurant(
    String restaurantId, String statusMode) async {
  var orderStatusMode = statusMode == ORDER_CANCELEED ? -1 : 2;
  // ignore: unused_local_variable
  var userId = FirebaseAuth.instance.currentUser?.uid.toString();
  var list = new List<OrderModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(ORDER_REF)
    
      .once();
  var values = source.snapshot;
  values.children.forEach((element) {
    list.add(OrderModel.fromJson(jsonDecode(jsonEncode(element.value))));
  });
  //log("user id$userId");
  if (values.exists) {
    print(
        "*****************has DATA**********************************${values.value}");
  } else {
    print(
        "no data ***************************************************${values.value}");
  }
  log("*****${source.snapshot.value.toString()}");
  return list
      .where((element) => statusMode == ORDER_PROCESSING
          ? (element.orderStatus == 0 || element.orderStatus == 1)
          : element.orderStatus == orderStatusMode)
      .toList();
}
