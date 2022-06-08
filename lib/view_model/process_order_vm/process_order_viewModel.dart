import 'package:order_food/model/order_model.dart';
import 'package:order_food/state/cart_state.dart';

abstract class ProcessOrderViewModel {
  Future<bool> submitOrder(OrderModel orderModel);

  Future<OrderModel> creatOrderModel(
      {required String restaurantId,
      required double discount,
      required String firstName,
      required String lastName,
      required String address,
      required String comment,
      required bool isCod,
      required CartStateController cartStateController});
}
