import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:order_food/widget/main/restaurant_info_widget.dart';

class RestaurantImageWidget extends StatelessWidget {
  const RestaurantImageWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.address,
  }) : super(key: key);
  final String imageUrl;
  final String name, address;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
         
            CachedNetworkImage(
                //height: 230,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.image),
              ),
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            
            RestaurantInfoWidget(
              address: address,
              name: name,
            )
          ],
        ),
      ),
    );
  }
}
