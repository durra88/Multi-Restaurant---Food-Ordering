import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../state/cart_state.dart';

class CartImageWidget extends StatelessWidget {
  final CartStateController controller;
  final String ImageUrl;
  const CartImageWidget(
      {Key? key, required this.controller, required this.ImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ImageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Center(
        child: Icon(Icons.image),
      ),
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}