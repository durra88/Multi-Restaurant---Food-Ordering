import 'package:order_food/firebase/best_deal_reference.dart';
import 'package:order_food/firebase/popular_reference.dart';
import 'package:order_food/model/popular_item_model.dart';
import 'package:order_food/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';

class RestaurantHomeDetailViewModelImp implements RestaurantHomeDetailViewModel {
  @override
  Future<List<PopularItemModel>> displayMostPopularByRestaurntId(
      String restaurantId) {
    return getMostPopularByRestaurntId(restaurantId);
  }

  @override
  Future<List<PopularItemModel>> displayBestDealsByRestaurntId(String restaurantId) {
     return getBestDealByRestaurntId(restaurantId);
  }
}
