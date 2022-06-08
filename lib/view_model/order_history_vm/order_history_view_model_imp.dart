import 'package:order_food/firebase/order_reference.dart';
import 'package:order_food/model/order_model.dart';
import 'package:order_food/view_model/order_history_vm/order_history_viewModel.dart';

class OrderHistoryViewModelImp extends OrderViewModel {
  @override
  Future<List<OrderModel>> getUserHistory(String restaurantId, String statusMode) {

    return getUserOrdersByRestaurant(restaurantId,statusMode);
  }
}
