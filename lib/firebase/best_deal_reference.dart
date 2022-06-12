import 'dart:convert' as html;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../const/const.dart';
import '../model/popular_item_model.dart';

Future<List<PopularItemModel>> getBestDealByRestaurntId(
    String restaurantId) async {
  var list = List<PopularItemModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(BEST_DEALS_REF)
      .once();
  var values = source.snapshot;
  values.children.forEach((element) {
    list.add(PopularItemModel.fromJson(jsonDecode(html.jsonEncode(element.value))));
  });
  return list;
}
