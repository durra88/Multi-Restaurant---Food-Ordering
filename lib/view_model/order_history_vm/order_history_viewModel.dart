import 'package:order_food/model/order_model.dart';

abstract class OrderViewModel {
 Future<List<OrderModel>> getUserHistory(String restaurantId,String statusMode);
}
