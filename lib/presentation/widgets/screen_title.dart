import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              fontSize: 27, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
