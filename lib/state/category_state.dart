import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:order_food/model/category_model.dart';
import 'package:get/get.dart'; 

class CategoryStateController extends GetxController {
  var selectedCategory = CategoryModel(name: 'name', image: 'image', foods: []).obs;
  
}
