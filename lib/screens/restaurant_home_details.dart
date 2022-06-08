import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/model/popular_item_model.dart';
import 'dart:core';
import 'package:order_food/state/main_state.dart';
import 'package:order_food/strings/restaurant_home_string.dart';
import 'package:order_food/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm_imp.dart';

import 'package:order_food/widget/common/common_widgets.dart';

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
            Expanded(
              flex: 1,
              child: Container(
                child: FutureBuilder(
                    future: viewModel.displayMostPopularByRestaurntId(
                        mainStateController
                            .selectedRestaurant.value.restaurantId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        var lstPopular =
                            snapshot.data as List<PopularItemModel>;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mostPopularText,
                              style: GoogleFonts.jetBrainsMono(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.black45),
                            ),
                            Expanded(
                              child: LiveList(
                                showItemDuration: Duration(milliseconds: 350),
                                showItemInterval: Duration(milliseconds: 150),
                                reAnimateOnVisibility: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: lstPopular.length,
                                itemBuilder: animationItemBuilder(
                                  (index) => Container(
                                    padding: const EdgeInsets.all(8),
                                    child: FittedBox(
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                lstPopular[index].image!),
                                            minRadius: 40,
                                            maxRadius: 60,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            lstPopular[index].name!,
                                            style: GoogleFonts.jetBrainsMono(
                                               ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  child: FutureBuilder(
                    future: viewModel.displayBestDealsByRestaurntId(
                        mainStateController
                            .selectedRestaurant.value.restaurantId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        var lstBestDealer =
                            snapshot.data as List<PopularItemModel>;
                        return CarouselSlider(
                            items: lstBestDealer
                                .map((e) =>
                                    Builder(builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Card(
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                    sigmaX: 5, sigmaY: 5),
                                                child: CachedNetworkImage(
                                                  imageUrl: e.image!,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                    child: Icon(Icons.image),
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  '${e.name}',
                                                  style:
                                                      GoogleFonts.jetBrainsMono(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }))
                                .toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayAnimationDuration: Duration(seconds: 2),
                              autoPlayCurve: Curves.easeIn,
                              height: double.infinity,
                            ));
                      }
                    },
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
