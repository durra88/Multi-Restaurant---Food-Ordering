import 'package:order_food/firebase/category_reference.dart';
import 'package:order_food/model/category_model.dart';

import 'category_viewmodel.dart';

class CategoryViewModelImp implements CategoryViewModel {
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurntId(
      String restaurantId) {
    return getCategoryByRestaurntId(restaurantId);
  }
}
