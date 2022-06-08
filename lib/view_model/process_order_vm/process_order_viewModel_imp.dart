import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_food/firebase/order_reference.dart';
import 'package:order_food/firebase/server_time_offset_reference.dart';
import 'package:order_food/model/order_model.dart';
import 'package:order_food/state/cart_state.dart';
import 'package:order_food/utils/utils.dart';
import 'package:order_food/view_model/process_order_vm/process_order_viewModel.dart';

class ProcessOrderViewModelImp extends ProcessOrderViewModel {
  @override
  Future<bool> submitOrder(OrderModel orderModel) {
    return writeOrderToFirebase(orderModel);
  }

  @override
  Future<OrderModel> creatOrderModel(
      {required String restaurantId,
      required double discount,
      required String firstName,
      required String lastName,
      required String address,
      required String comment,
      required bool isCod,
      required CartStateController cartStateController}) async {
    var serverTime = await getServerTimeOffset();
    return new OrderModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: '$firstName $lastName',
        userPhone: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        shippingAddress: address,
        comment: comment,
        orderNumber: createOrderNumber(serverTime).toString(),
        restaurantId: restaurantId,
        totalPayment: cartStateController.getSubTotal(restaurantId),
        finalPayment: calculateFinalPayement(
            cartStateController.getSubTotal(restaurantId), discount),
        shippingCost: cartStateController.getShippingFee(restaurantId),
        discount: discount,
        isCod: isCod,
        cartItemList: cartStateController.getCart(restaurantId),
        orderStatus: 0,
        createdDate: serverTime);
  }
}
