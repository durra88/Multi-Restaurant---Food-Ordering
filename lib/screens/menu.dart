import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';
import '../strings/main_strings.dart';
import '../strings/restaurant_home_string.dart';
import '../view_model/menu_vm/menu_viewmodel_imp.dart';
import '../widget/menu/categories_menu_widget.dart';
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
            thickness: 1,
            color: Colors.red,
          ),
          MenuItemWidget(
            title: homeText,
            onTap: () => zoomdRrawerController.toggle!(),
            icon: Icons.home,
          ),
          Divider(
            thickness: 1,
            color: Colors.red,
          ),
          MenuItemWidget(
            title: restaurentListText,
            onTap: viewModel.backToRestaurantList,
            icon: Icons.restaurant_rounded,
          ),
          Divider(
            thickness: 1,
            color: Colors.red,
          ),
          MenuItemWidget(
            title: cartText,
            onTap: viewModel.navigateCart,
            icon: Icons.shopping_cart_rounded,
          ),
          Divider(
            thickness: 1,
            color: Colors.red,
          ),
          MenuItemWidget(
            title: categoriesText,
            onTap: viewModel.navigateCategories,
            icon: Icons.list,
          ),
          Divider(
            thickness: 1,
            color: Colors.red,
          ),
          MenuItemWidget(
            title: orderHistoryText,
            onTap: () => Get.to(OrderHistoryScreen()),
            icon: Icons.history,
          ),
          Spacer(),
          Divider(
            thickness: 1,
            color: Colors.red,
          ),
          InkWell(
            onTap: () => viewModel.checkLoginState(context)
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
                    viewModel.checkLoginState(context) ? logoutText : loginText,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      )),
    );
  }
}
