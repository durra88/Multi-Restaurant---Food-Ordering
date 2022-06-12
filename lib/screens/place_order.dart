import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'restaurant_home.dart';
import '../state/cart_state.dart';
import '../state/main_state.dart';
import '../state/place_order_state.dart';
import '../strings/cart_string.dart';
import '../strings/place_order_string.dart';
import '../view_model/process_order_vm/process_order_viewModel_imp.dart';

class PlaceOrderScreen extends StatelessWidget {
  final placeOrderState = Get.put(PlaceOrderController());
  final placeOrderVM = ProcessOrderViewModelImp();
  final CartStateController cartStateController = Get.find();
  final MainStateController mainStateController = Get.find();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(placeOrderText),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: firstNameController,
                      /*      validator: ValidationBuilder(
                              requiredMessage:
                                  '$firstNameText $isRequiredText')
                          .required
                          .build,*/
                      decoration: InputDecoration(
                          hintText: firstNameText,
                          labelText: firstNameText,
                          border: OutlineInputBorder()),
                    )),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: lastNameController,
                      /*      validator: ValidationBuilder(
                              requiredMessage:
                                  '$lastNameText $isRequiredText')
                          .required
                          .build,*/
                      decoration: InputDecoration(
                          hintText: lastNameText,
                          labelText: lastNameText,
                          border: OutlineInputBorder()),
                    )),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: addressController,
                      /*      validator: ValidationBuilder(
                              requiredMessage:
                                  '$addressText $isRequiredText')
                          .required
                          .build,*/
                      decoration: InputDecoration(
                          hintText: addressText,
                          labelText: addressText,
                          border: OutlineInputBorder()),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentText,
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        RadioListTile<String>(
                            title: Text(codText),
                            value: COD_VAL,
                            groupValue: placeOrderState.paymentSelected.value,
                            onChanged: (String? val) {
                              placeOrderState.paymentSelected.value = val!;
                            }),
                        RadioListTile<String>(
                            title: Text(braintreeText),
                            value: BRAINTREE_VAL,
                            groupValue: placeOrderState.paymentSelected.value,
                            onChanged: (String? val) {
                              placeOrderState.paymentSelected.value = val!;
                            }),
                      ],
                    )),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: commentController,
                      /*      validator: ValidationBuilder(
                              requiredMessage:
                                  '$commentText $isRequiredText')
                          .required
                          .build,*/
                      decoration: InputDecoration(
                          hintText: commentText,
                          labelText: commentText,
                          border: OutlineInputBorder()),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var order = await placeOrderVM.creatOrderModel(
                              restaurantId: mainStateController
                                  .selectedRestaurant.value.restaurantId!,
                              discount: 0,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              address: addressController.text,
                              comment: commentController.text,
                              // ignore: unrelated_type_equality_checks
                              isCod: placeOrderState.paymentSelected == COD_VAL
                                  ? true
                                  : false,
                              cartStateController: cartStateController);
                          print('orderinfo${order.toJson()}');
                          var result = await placeOrderVM.submitOrder(order);
                          Get.defaultDialog(
                              title:
                                  result ? orderSuccessText : orderFailedText,
                              middleText: result
                                  ? orderSuccessMessageText
                                  : orderFaildMessageText,
                              textCancel: cancelText,
                              textConfirm: confirmText,
                              onCancel: (){},
                              confirmTextColor: Colors.yellow,
                              onConfirm: () {
                                cartStateController.clearCart(
                                    mainStateController.selectedRestaurant.value
                                        .restaurantId!);
                                      Get.offAll(()=>RestaurantHome());
                              });
                        }
                      },
                      child: Text(placeOrderText)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
