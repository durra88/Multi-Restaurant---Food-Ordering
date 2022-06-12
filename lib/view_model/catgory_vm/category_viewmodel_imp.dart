import '../../firebase/category_reference.dart';
import '../../model/category_model.dart';
import 'category_viewmodel.dart';

class CategoryViewModelImp implements CategoryViewModel {
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurntId(
      String restaurantId) {
    return getCategoryByRestaurntId(restaurantId);
  }
}
