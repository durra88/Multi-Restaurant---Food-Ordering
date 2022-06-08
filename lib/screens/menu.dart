import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/const/const.dart';
import 'package:order_food/strings/main_strings.dart';
import 'package:order_food/strings/restaurant_home_string.dart';
import 'package:order_food/view_model/menu_vm/menu_viewmodel_imp.dart';

import 'order_history.dart';

class MenuScreen extends StatelessWidget {
  final viewModel = MenuViewModelImp();
  final ZoomDrawerController zoomdRrawerController;
  MenuScreen(this.zoomdRrawerController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(COLOR_MENU_BG),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: CircleAvatar(
                        maxRadius: 40,
                        backgroundColor: Color(COLOR_ICON_DRAWER),
                        child: Icon(
                          Icons.restaurant,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,  color: Colors.red,
          ),
          InkWell(
            onTap: () => zoomdRrawerController.toggle!(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    homeText,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.red,
          ),
          InkWell(
            onTap: viewModel.backToRestaurantList,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.restaurant_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    restaurentListText,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,  color: Colors.red,
          ),
          InkWell(
            onTap: viewModel.navigateCart,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    cartText,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,  color: Colors.red,
          ),
          InkWell(
            onTap: viewModel.navigateCategories,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    categoriesText,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,  color: Colors.red,
          ),
          InkWell(

             onTap: () => Get.to( OrderHistoryScreen()),
              // viewModel.checkLoginState(context)
              //     ? viewModel.viewOrderHistory
              //     : viewModel.login,


            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    orderHistoryText,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Divider(
            thickness: 1,  color: Colors.red,
          ),
          InkWell(
              onTap:()=> viewModel.checkLoginState(context)
                  ? viewModel.logout
                  : viewModel.login,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    viewModel.checkLoginState(context)
                        ? Icons.logout
                        : Icons.login,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    viewModel.checkLoginState(context)
                        ? logoutText
                        : loginText,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
     SizedBox(height: 10,)
        ],
      )),
    );
  }
}
