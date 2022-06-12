import '../../firebase/best_deal_reference.dart';
import '../../firebase/popular_reference.dart';
import '../../model/popular_item_model.dart';
import 'restaurant_home_detail_vm.dart';

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
