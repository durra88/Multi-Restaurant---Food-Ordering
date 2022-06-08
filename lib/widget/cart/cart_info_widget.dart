import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/model/cart_model.dart';
import 'package:order_food/state/cart_state.dart';
import 'package:order_food/utils/utils.dart';

class CartInfoWidget extends StatelessWidget {
  final CartStateController controller;
  final CartModel cartModel;
  const CartInfoWidget(
      {Key? key, required this.controller, required this.cartModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(cartModel.name!,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                      currencyFormat.format(
                        cartModel.price.toString(),
                      ),
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              )),
        ],
      ),
    );
  }
}
