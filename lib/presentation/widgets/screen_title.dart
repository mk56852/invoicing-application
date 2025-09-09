import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management_app/configuration/app_config.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.arrow_right_outlined,
          size: 40,
        ),
        Text(
          title,
          style: GoogleFonts.roboto(
              fontSize: 27,
              color: SimpleAppColors.blueColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
