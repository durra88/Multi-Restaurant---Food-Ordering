import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantInfoWidget extends StatelessWidget {
  final String name, address;

  const RestaurantInfoWidget({
    required this.name,
    required this.address,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(
          name,
          style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        subtitle: Text(
          address,
          style: GoogleFonts.abel(fontWeight: FontWeight.w400, fontSize: 12),
        ),
        leading: Icon(
          Icons.location_pin,
          color: Colors.green,
          size: 20,
        ),
        trailing: RatingBar.builder(
            initialRating: 4.5,
            itemSize: 20,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemBuilder: (context, _) {
              return Icon(
                Icons.star,
                color: Color.fromARGB(255, 236, 198, 4),
              );
            },
            onRatingUpdate: (value) {}),
      ),
    );
  }
}
