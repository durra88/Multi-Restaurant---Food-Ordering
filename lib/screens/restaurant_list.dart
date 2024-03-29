import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/cart_model.dart';
import '../model/restaurent_model.dart';
import '../state/cart_state.dart';
import '../state/main_state.dart';
import '../strings/main_strings.dart';
import '../utils/const.dart';
import '../view_model/main_vm/main_view_model_imp.dart';
import '../widget/common/common_widgets.dart';
import '../widget/main/main_widgets.dart';
import 'restaurant_home.dart';

class RestaurentListScreen extends StatefulWidget {
  final FirebaseApp app;
  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());
  final cartStateController = Get.put(CartStateController());
  final box = GetStorage();

  RestaurentListScreen({required this.app});

  @override
  _RestaurentListScreenState createState() => _RestaurentListScreenState();
}

class _RestaurentListScreenState extends State<RestaurentListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.box.hasData(MY_CART_KEY)) {
        var cartSave = await widget.box.read(MY_CART_KEY) as String;
        if (cartSave.length > 0 && cartSave.isNotEmpty) {
          final listCart = jsonDecode(cartSave) as List<dynamic>;
          final listCartParsed =
              listCart.map((e) => CartModel.fromJson(e)).toList();
          if (listCartParsed.length > 0)
            widget.cartStateController.cart.value = listCartParsed;
        }
      } else {
        widget.cartStateController.cart.value =
            new List<CartModel>.empty(growable: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurentText,
          style: GoogleFonts.jetBrainsMono(
              fontWeight: FontWeight.w900, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: FutureBuilder(
        future: widget.viewModel.displayRestaurantList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lst = snapshot.data as List<RestaurantModel>;
            return Container(
              margin: const EdgeInsets.only(top: 20),
              height: 10000,
              child: LiveList(
                  shrinkWrap: true,
                  showItemDuration: Duration(milliseconds: 350),
                  showItemInterval: Duration(milliseconds: 150),
                  reAnimateOnVisibility: true,
                  scrollDirection: Axis.vertical,
                  itemCount: lst.length,
                  itemBuilder: animationItemBuilder((index) => InkWell(
                        onTap: () {
                          widget.mainStateController.selectedRestaurant.value =
                              lst[index];
                          Get.to(() => RestaurantHome());
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            height:
                                MediaQuery.of(context).size.height / 2.6 * 1.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RestaurantImageWidget(
                                  imageUrl: lst[index].imageUrl!,
                                  name: lst[index].name!,
                                  address: lst[index].address!,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))),
            );
          }
        },
      ),
    );
  }
}
