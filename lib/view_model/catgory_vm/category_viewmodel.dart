import 'package:order_food/model/category_model.dart';

abstract class CategoryViewModel {
  Future<List<CategoryModel>> displayCategoryByRestaurntId(String restaurantId);
}
