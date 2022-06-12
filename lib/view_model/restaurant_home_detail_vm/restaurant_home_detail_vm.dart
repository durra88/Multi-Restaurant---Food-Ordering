import '../../model/popular_item_model.dart';

abstract class RestaurantHomeDetailViewModel {
  Future<List<PopularItemModel>>displayMostPopularByRestaurntId(
      String restaurantId);
        Future<List<PopularItemModel>>displayBestDealsByRestaurntId(
      String restaurantId);
      
}
