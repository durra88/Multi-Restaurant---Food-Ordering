import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/const/const.dart';
import 'package:order_food/model/category_model.dart';
import 'package:order_food/state/category_state.dart';
import 'package:order_food/state/main_state.dart';
import 'package:order_food/view_model/catgory_vm/category_viewmodel_imp.dart';
import 'package:order_food/widget/common/appbar_with_cart_widget.dart';
import 'package:order_food/widget/common/common_widgets.dart';
import 'food_list.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = CategoryViewModelImp();
    final MainStateController mainStateController = Get.find();
    final CategoryStateController categoryStateController =
        Get.put(CategoryStateController());

    return Scaffold(
      appBar: AppBarWithCartButton(
        title: '${mainStateController.selectedRestaurant.value.name}',
      ),
      body: FutureBuilder(
        future: viewModel.displayCategoryByRestaurntId(
            mainStateController.selectedRestaurant.value.restaurantId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lst = snapshot.data as List<CategoryModel>;

            return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Expanded(
                        child: LiveGrid(
                      showItemDuration: Duration(milliseconds: 300),
                      showItemInterval: Duration(milliseconds: 300),
                      reAnimateOnVisibility: true,
                      scrollDirection: Axis.vertical,
                      itemCount: lst.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1),
                      itemBuilder: animationItemBuilder((index) => InkWell(
                            onTap: () {
                              categoryStateController.selectedCategory.value =
                                  lst[index];
                              print(
                                  'food ${categoryStateController.selectedCategory.value.foods}');
                              Get.to(() => FoodListScreen());
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: lst[index].image!,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Icon(Icons.image),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  Container(color: Color(COLOR_OVERLAY)),
                                  Center(
                                    child: Text(
                                      '${lst[index].name}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.jetBrainsMono(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ))
                  ],
                ));
          }
        },
      ),
    );
  }
}
