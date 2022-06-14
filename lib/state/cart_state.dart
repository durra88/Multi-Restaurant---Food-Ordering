import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/cart_model.dart';
import '../model/food_model.dart';
import '../strings/cart_string.dart';
import '../utils/const.dart';

class CartStateController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  List<CartModel> getAnonymousCart(String restaurantId) => cart
      .where((item) =>
          item.restaurantId == restaurantId && item.userUid == KEY_ANONYMOS)
      .toList().obs;

  List<CartModel> getCart(String restaurantId) => cart
      .where((item) =>
          item.restaurantId == restaurantId &&
          (FirebaseAuth.instance.currentUser == null
              ? item.userUid == KEY_ANONYMOS
              : item.userUid == FirebaseAuth.instance.currentUser!.uid))
      .toList().obs;
  addToCart(FoodModel foodModel, String restaurantId, {quantity: 1}) async {
    try {
      var cartItem = CartModel(
          id: foodModel.id,
          name: foodModel.name,
          description: foodModel.description,
          image: foodModel.image,
          price: foodModel.price,
          addon: foodModel.addon,
          size: foodModel.size,
          quantity: 1,
          restaurantId: restaurantId,
          userUid: FirebaseAuth.instance.currentUser == null
              ? KEY_ANONYMOS
              : FirebaseAuth.instance.currentUser!.uid);
      if (isExists(cartItem, restaurantId)) {
        //!if cartItem already exist update the quantity
        var foodNeedToUpdate = getCartNeedToUpdate(cartItem, restaurantId);
        if (foodNeedToUpdate != null)
          foodNeedToUpdate.quantity = quantity + quantity as int;
      } else {
        cart.add(cartItem);
      }
      var jsonDBEncode = jsonEncode(cart);
      await box.write(MY_CART_KEY, jsonDBEncode);
      cart.refresh(); //update
      Get.snackbar(successTitle, successMessage);
    } catch (e) {
      Get.snackbar(errorTitle, e.toString());
    }
  }

  isExists(CartModel cartItem, String restaurantId) => cart.any((e) =>
      e.id == cartItem.id &&
      e.restaurantId == restaurantId &&
      e.userUid ==
          (FirebaseAuth.instance.currentUser == null
              ? KEY_ANONYMOS
              : FirebaseAuth.instance.currentUser!.uid));

  sumCart(String? restaurantId) => getCart(restaurantId!).length == 0
      ? 0
      : cart
          .map((e) => e.price! * e.quantity!)
          .reduce((value, element) => value + element);

  getQuantity(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.quantity!)
          .reduce((value, element) => value + element);

  getShippingFee(String restaurantId) =>
      sumCart(restaurantId) * 0.1; //10% of total value
  getSubTotal(String restaurantId) =>
      sumCart(restaurantId) + getShippingFee(restaurantId);
  clearCart(String restaurantId) {
    cart.value = getCart(restaurantId);
    cart.clear();
    saveDatabase();
  }

  void mergeCart(List<CartModel> cartItems, String restaurantId) {
    if (cart.length > 0) {
      cartItems.forEach((cartItem) {
        if (isExists(cartItem, restaurantId)) {
          var foodNeedToUpdate = getCartNeedToUpdate(cartItem, restaurantId);
          if (foodNeedToUpdate == null) {
            foodNeedToUpdate.quantity += cartItem.quantity;
          } else {
            var newCart = cartItem;
            newCart.userUid = FirebaseAuth.instance.currentUser!.uid;
            cart.add(newCart);
          }
        }
      });
    }
  }

  saveDatabase() => box.write(MY_CART_KEY, jsonEncode(cart));

  getCartNeedToUpdate(CartModel cartItem, String restaurantId) =>
      cart.firstWhere((e) =>
          e.id == cartItem.id &&
          e.restaurantId == restaurantId &&
          e.userUid ==
              (FirebaseAuth.instance.currentUser == null
                  ? KEY_ANONYMOS
                  : FirebaseAuth.instance.currentUser!.uid));


}
