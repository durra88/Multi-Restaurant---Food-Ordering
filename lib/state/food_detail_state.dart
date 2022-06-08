import 'package:get/get.dart';
import 'package:order_food/model/addon_model.dart';
import 'package:order_food/model/size_model.dart';

class FoodDetailStateController extends GetxController {
  var quantity = 1.obs;
  var selectedSize = SizeModel(name: 'name', price: 0).obs;
  var selectedAddon = List<AddonModel>.empty(growable: true).obs; 
}
