import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../screens/cart.dart';
import '../../screens/category.dart';
import '../../screens/order_history.dart';
import '../../screens/restaurant_home.dart';
import '../../state/cart_state.dart';
import '../../state/main_state.dart';
import '../../strings/main_strings.dart';
import '../../utils/const.dart';
import 'menu_viewmodel.dart';

class MenuViewModelImp implements MenuViewModel {
  final cartStateController = Get.put(CartStateController());
  final mainStateController = Get.put(MainStateController());
  @override
  void navigateCategories() {
    Get.to(() => CategoryScreen());
  }

  void backToRestaurantList() {
    Get.back(closeOverlays: true, canPop: true);
  }

  @override
  bool checkLoginState(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  @override
  void login(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      FlutterAuthUi.startUi(
              items: [AuthUiProvider.phone],
              tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                  tosUrl: 'https://google.com',
                  privacyPolicyUrl: 'https://youtube.com'),
              androidOption: AndroidOption(
                  enableSmartLock: false, showLogo: true, overrideTheme: true))
          .then((value) async {
        navigationHome(context);
      }).catchError((e) {
        Get.snackbar('Error', '$e');
      });
    }
  }

  @override
  void logout(BuildContext context) {
    Get.defaultDialog(
        title: logoutTitle,
        content: Text(logoutMessageText),
        backgroundColor: Colors.white,
        cancel: ElevatedButton(
            onPressed: () => Get.back(), child: Text(cancelText)),
        confirm: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) => Get.offAll(RestaurantHome()));
            },
            child: Text(
              confirmText,
              style: TextStyle(color: Colors.red),
            )));
  }

  @override
  void navigationHome(BuildContext context) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var box = GetStorage();
    box.write(KEY_TOKEN, token);
    if (cartStateController.cart.length > 0) {
      var newCart = cartStateController.getAnonymousCart(
          mainStateController.selectedRestaurant.value.restaurantId!);
      newCart.forEach((element) =>
          element.userUid = FirebaseAuth.instance.currentUser!.uid);
      cartStateController.saveDatabase();
      print(jsonEncode(cartStateController.cart));
    }
    Get.offAll(() => RestaurantHome);
  }

  @override
  void navigateCart() => Get.to(CartDetailScreen());

  @override
  void viewOrderHistory(BuildContext context) {
    Get.to(() => OrderHistoryScreen);
    print('order history');
  }
}
