import 'package:order_food/model/restaurent_model.dart';

abstract class MainViewModel {
  Future<List<RestaurantModel>> displayRestaurantList();
}
