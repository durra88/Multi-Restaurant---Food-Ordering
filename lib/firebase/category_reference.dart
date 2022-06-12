import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../const/const.dart';
import '../model/category_model.dart';

Future<List<CategoryModel>> getCategoryByRestaurntId(
    String restaurantId) async {
  var list = List<CategoryModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(CATEGORY_REF)
      .once();
  var values = source.snapshot;
  values.children.forEach((element) {
    list.add(CategoryModel.fromJson(jsonDecode(jsonEncode(element.value))));

  //log("category-***---------${CategoryModel.fromJson(jsonDecode(jsonEncode(element.value))).toJson()}");
  });

  return list;
}
