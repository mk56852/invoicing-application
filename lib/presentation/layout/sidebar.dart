import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
        minWidth: 300,
      ),
      height: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "Maitre",
          style: GoogleFonts.dancingScript(fontSize: 24, color: Colors.white),
        ),
        Text(
          "Nessrine Karray",
          style: GoogleFonts.dancingScript(fontSize: 24, color: Colors.white),
        ),
      ]),
    );
  }
}
