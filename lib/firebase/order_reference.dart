import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_food/const/const.dart';
import 'package:order_food/model/order_model.dart';

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

Future<List<OrderModel>> getUserOrdersByRestaurant(String restaurantId,String statusMode) async {
  var orderStatusMode = statusMode==ORDER_CANCELEED? -1:2;
  var userId = FirebaseAuth.instance.currentUser?.uid;
  var list = new List<OrderModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(ORDER_REF)
      //.child('orderNumber')
      .orderByChild('userId')
      .equalTo('userId')
      .once();
  var  values = source.snapshot;
  values.children. forEach((element) {
    list.add(OrderModel.fromJson(jsonDecode(jsonEncode(element.value))));

  });


  if(values.value==null){
    print("*****************NO DATA**********************************${values.value}");
  }else{
    print("has data ***************************************************${values.value}");
  }


  return list
      .where((element) => statusMode == ORDER_PROCESSING
       ?(element.orderStatus==0 || element.orderStatus == 1)
      :element.orderStatus==orderStatusMode)
      .toList();
}