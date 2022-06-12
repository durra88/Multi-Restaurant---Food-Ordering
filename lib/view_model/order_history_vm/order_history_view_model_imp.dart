import '../../firebase/order_reference.dart';
import '../../model/order_model.dart';
import 'order_history_viewModel.dart';

class OrderHistoryViewModelImp extends OrderViewModel {
  @override
  Future<List<OrderModel>> getUserHistory(String restaurantId, String statusMode) {

    return getUserOrdersByRestaurant(restaurantId,statusMode);
  }
}
