import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import '../state/main_state.dart';
import '../view_model/restaurant_home_detail_vm/restaurant_home_detail_vm_imp.dart';

import '../widget/restaurant_home/best_deal_widget.dart';
import '../widget/restaurant_home/most_popular_widget.dart';

class RestaurantHomeDetails extends StatelessWidget {
  final MainStateController mainStateController =
      Get.put(MainStateController());
  final viewModel = RestaurantHomeDetailViewModelImp();
  final ZoomDrawerController zoomDrawerController;

  RestaurantHomeDetails(this.zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          '${mainStateController.selectedRestaurant.value.name}',
          style: GoogleFonts.jetBrainsMono(
              color: Colors.black, fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10,
        iconTheme: IconThemeData(color: Colors.black),
        leading: InkWell(
          child: Icon(Icons.view_headline),
          onTap: () => zoomDrawerController.toggle!(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            MostPopularWidget(
                viewModel: viewModel, mainStateController: mainStateController),
            BestDealWidget(
                viewModel: viewModel, mainStateController: mainStateController),
          ],
        ),
      ),
    ));
  }
}
