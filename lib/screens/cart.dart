import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../state/cart_state.dart';
import '../state/main_state.dart';
import '../strings/cart_string.dart';
import '../utils/utils.dart';
import '../view_model/cart_mv/cart_view_model_imp.dart';
import '../widget/cart/cart_image_widget.dart';
import '../widget/cart/cart_info_widget.dart';
import '../widget/cart/cart_total_item_widget.dart';

class CartDetailScreen extends StatelessWidget {
  final CartStateController controller = Get.find();
  final MainStateController mainStateController = Get.find();
  final box = GetStorage();
  final CartViewModelImp cartViewModel = new CartViewModelImp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
        actions: [
          controller.getQuantity(mainStateController
                      .selectedRestaurant.value.restaurantId!) >
                  0
              ? IconButton(
                  onPressed: () => Get.defaultDialog(
                      title: clearCartConfirmTitleText,
                      middleText: clearCartConfirmContentText,
                      textCancel: cancelText,
                      textConfirm: confirmText,
                      confirmTextColor: Colors.yellow,
                      buttonColor: Colors.blueAccent,
                      onConfirm: () => cartViewModel.clearCart(controller)),
                  icon: Icon(Icons.clear))
              : Container(),
        ],
      ),
      body: controller.getQuantity(
                  mainStateController.selectedRestaurant.value.restaurantId!) >
              0
          ? Obx(
              () {
                // log("__+++++${controller.getQuantity(mainStateController.selectedRestaurant.value.restaurantId!)}");

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller
                            .getCart(mainStateController
                                .selectedRestaurant.value.restaurantId!)
                            .length,
                        itemBuilder: (context, index) => Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (BuildContext context) =>
                                    Get.defaultDialog(
                                        title: deleteCartConfirmTitleText,
                                        content:
                                            Text(deleteCartConfirmContentText),
                                        textCancel: cancelText,
                                        textConfirm: confirmText,
                                        confirmTextColor: Colors.yellow,
                                        onConfirm: () {
                                          cartViewModel.deleteCart(
                                              controller,
                                              mainStateController
                                                  .selectedRestaurant
                                                  .value
                                                  .restaurantId!,
                                              index);
                                          Get.back();
                                        }),
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 10,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6.0),
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CartImageWidget(
                                        ImageUrl: controller
                                            .getCart(mainStateController
                                                .selectedRestaurant
                                                .value
                                                .restaurantId!)[index]
                                            .image!,
                                        controller: controller),
                                  ),
                                  CartInfoWidget(
                                      controller: controller,
                                      mainStateController: mainStateController,
                                      name: controller
                                          .getCart(mainStateController
                                              .selectedRestaurant
                                              .value
                                              .restaurantId!)[index]
                                          .name!,
                                      price: currencyFormat.format(
                                        controller
                                            .getCart(mainStateController
                                                .selectedRestaurant
                                                .value
                                                .restaurantId!)[index]
                                            .price!,
                                      )),
                                  
                            
                                  Center(
                                    child: ElegantNumberButton(
                                        initialValue: controller
                                            .getCart(mainStateController
                                                .selectedRestaurant
                                                .value
                                                .restaurantId!)[index]
                                            .quantity!,
                                        minValue: 1,
                                        maxValue: 100,
                                        color: Colors.amber,
                                        onChanged: (value) {
                                          cartViewModel.updateCart(
                                              controller,
                                              mainStateController
                                                  .selectedRestaurant
                                                  .value
                                                  .restaurantId!,
                                              index,
                                              value.toInt());
                                        },
                                        decimalPlaces: 0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 12,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            TotalItemWidget(
                                text: totalText,
                                value: currencyFormat.format(controller.sumCart(
                                    mainStateController.selectedRestaurant.value
                                            .restaurantId ??
                                        "")),
                                isSubTotal: false),
                            Divider(
                              thickness: 2,
                            ),
                            TotalItemWidget(
                                text: shippingFeeText,
                                value: currencyFormat.format(controller
                                    .getShippingFee(mainStateController
                                            .selectedRestaurant
                                            .value
                                            .restaurantId ??
                                        "")),
                                isSubTotal: false),
                            Divider(
                              thickness: 2,
                            ),
                            TotalItemWidget(
                                text: subTotalText,
                                value: currencyFormat.format(
                                    controller.getSubTotal(mainStateController
                                            .selectedRestaurant
                                            .value
                                            .restaurantId ??
                                        "")),
                                isSubTotal: true),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  cartViewModel.processCheckout(
                                      context,
                                      controller.getCart(mainStateController
                                              .selectedRestaurant
                                              .value
                                              .restaurantId ??
                                          ""));
                                },
                                child: Text(checkOutText),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Text(cartEmptyText),
            ),
    );
  }
}
