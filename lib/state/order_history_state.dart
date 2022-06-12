import 'package:get/state_manager.dart';

import '../model/cart_model.dart';
import '../model/order_model.dart';

class OrderHistoryController extends GetxController {
  var selectedOrder = new OrderModel(
      userId: 'userId',
      userName: 'userName',
      userPhone: 'userPhone',
      shippingAddress: 'shippingAddress',
      comment: 'comment',
      orderNumber: 'orderNumber',
      restaurantId: 'restaurantId',
      totalPayment: 0,
      finalPayment: 0,
      shippingCost: 0,
      discount: 0,
      isCod: true,
      cartItemList:new List<CartModel>.empty(),
      orderStatus: 0,
      createdDate: 0).obs;
}
