import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../model/cart_model.dart';
import '../../screens/place_order.dart';
import '../../state/cart_state.dart';
import '../../state/main_state.dart';
import 'cart_view_model.dart';
import '../menu_vm/menu_viewmodel_imp.dart';

class CartViewModelImp implements CartViewModel {
  final MainStateController mainStateController = Get.find();
  final MenuViewModelImp menuViewModelImp = new MenuViewModelImp();
  void updateCart(CartStateController controller, String restaurantId,
      int index, int value) {
    controller.cart.value = controller.getCart(restaurantId);
    controller.cart[index].quantity = value.toInt();
    controller.cart.refresh();
    controller.saveDatabase();
  }

  void deleteCart(
      CartStateController controller, String restaurantId, int index) {
    controller.cart.value = controller.getCart(restaurantId);
    controller.cart.removeAt(index);
    controller.saveDatabase();
  }

  void clearCart(CartStateController controller) {
    controller
        .clearCart(mainStateController.selectedRestaurant.value.restaurantId!);
  }

  @override
  processCheckout(BuildContext context, List<CartModel> cart) {
    if (FirebaseAuth.instance.currentUser != null) {
      Get.to(() => PlaceOrderScreen());
    } else {
      menuViewModelImp.login(context);
    }
  }
}
