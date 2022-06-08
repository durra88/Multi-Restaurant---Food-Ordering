import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/model/popular_item_model.dart';
import 'package:order_food/state/main_state.dart';
import 'package:order_food/strings/restaurant_home_string.dart';
import 'package:order_food/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';
import 'package:order_food/widget/common/common_widgets.dart';

class MostPopularWidget extends StatelessWidget {
  final MainStateController mainStateController;
  final RestaurantHomeDetailViewModel viewModel;

  const MostPopularWidget(
      {Key? key, required this.viewModel, required this.mainStateController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: viewModel.displayMostPopularByRestaurntId(
              mainStateController.selectedRestaurant.value.restaurantId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              var lstPopular = snapshot.data as List<PopularItemModel>;
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
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(lstPopular[index].image!),
                                minRadius: 40,
                                maxRadius: 60,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                lstPopular[index].name!,
                                style: GoogleFonts.jetBrainsMono(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
