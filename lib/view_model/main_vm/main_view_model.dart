import '../../model/restaurent_model.dart';

abstract class MainViewModel {
  Future<List<RestaurantModel>> displayRestaurantList();
}
