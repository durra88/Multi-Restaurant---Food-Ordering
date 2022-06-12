import '../../model/order_model.dart';

abstract class OrderViewModel {
 Future<List<OrderModel>> getUserHistory(String restaurantId,String statusMode);
}
