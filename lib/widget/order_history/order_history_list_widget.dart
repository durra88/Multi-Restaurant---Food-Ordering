import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/const/const.dart';
import 'package:order_food/model/order_model.dart';
import 'package:order_food/screens/order_view_detail.dart';
import 'package:order_food/state/order_history_state.dart';
import 'package:order_food/utils/utils.dart';
import 'package:order_food/widget/common/common_widgets.dart';

class OrderHistoryListWidget extends StatelessWidget {
  final List<OrderModel> listOrder;
  final OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());
  OrderHistoryListWidget({Key? key, required this.listOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [

       Expanded(
            child: LiveList(
          showItemInterval: Duration(microseconds: 300),
          showItemDuration: Duration(milliseconds: 300),
          reAnimateOnVisibility: true,
          scrollDirection: Axis.vertical,
          itemCount: listOrder.length,
          itemBuilder: animationItemBuilder((index) => InkWell(
                onTap: () {
                  print("000***************************************************${listOrder.toString().length}");

                  orderHistoryController.selectedOrder.value = listOrder[index];
                  Get.to(() => OrderViewDetailScreen());
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:  listOrder[index].cartItemList![0].image==null?"":listOrder[index].cartItemList![0].image!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, err) => Center(
                          child: Icon(Icons.image),
                        ),
                        progressIndicatorBuilder: (context, url, download) =>
                            Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Color(COLOR_OVERLAY),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              'Order #${listOrder[index].orderNumber}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.jetBrainsMono(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              )),
                                          Text(
                                              'Date #${convertToDate(listOrder[index].createdDate!)}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.jetBrainsMono(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              )),
                                          Text(
                                              'Order Status: #${convertStatus(listOrder[index].orderStatus!)}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.jetBrainsMono(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              )),
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ))
      ],
    );
  }
}
