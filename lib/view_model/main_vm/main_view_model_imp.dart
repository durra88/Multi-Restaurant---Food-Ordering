import 'package:order_food/firebase/restaurant_reference.dart';
import 'package:order_food/model/restaurent_model.dart';
import 'main_view_model.dart';

class MainViewModelImp implements MainViewModel {
  @override
  Future<List<RestaurantModel>> displayRestaurantList() {
    return getRestaurantList();
  }
}
