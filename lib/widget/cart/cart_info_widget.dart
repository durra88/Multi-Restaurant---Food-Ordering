import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state/cart_state.dart';
import '../../state/main_state.dart';

class CartInfoWidget extends StatelessWidget {
  const CartInfoWidget(
      {Key? key,
      required this.controller,
      required this.mainStateController,
      required this.price,
      required this.name})
      : super(key: key);

  final CartStateController controller;
  final MainStateController mainStateController;
  final String price, name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(name,
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
                  Text(price,
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
