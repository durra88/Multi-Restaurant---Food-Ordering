import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../strings/restaurant_home_string.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget(
      {Key? key,
      required this.zoomdRrawerController,
      required this.title,
      required this.onTap,required this.icon})
      : super(key: key);

  final ZoomDrawerController zoomdRrawerController;
  final title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              title,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
