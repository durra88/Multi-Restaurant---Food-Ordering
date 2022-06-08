import 'dart:convert' as html;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_food/const/const.dart';
import 'package:order_food/model/popular_item_model.dart';


Future<List<PopularItemModel>> getMostPopularByRestaurntId(
    String restaurantId) async {
  var list = List<PopularItemModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(MOST_POPULAR_REF)
      .once();
  var values = source.snapshot;
  values.children.forEach((element) {
    list.add(PopularItemModel.fromJson(jsonDecode(html.jsonEncode(element.value))));
  });
  return list;
}
