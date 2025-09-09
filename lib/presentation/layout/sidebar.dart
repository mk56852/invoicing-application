import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management_app/presentation/screens/home_screen.dart';
import 'package:management_app/presentation/screens/users_screen.dart';
import 'package:management_app/presentation/widgets/sidebar_item.dart';

class SideBar extends StatefulWidget {
  final Function updateScreen;
  const SideBar({super.key, required this.updateScreen});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
        minWidth: 300,
      ),
      height: double.maxFinite,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "Maitre",
          style: GoogleFonts.dancingScript(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "Nessrine Karray",
          style: GoogleFonts.dancingScript(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 100,
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedItemIndex = 0;
            });
            widget.updateScreen(UserScreen());
          },
          child: SideBarItem(
            name: "Propriétaire",
            icon: Icons.person_2_outlined,
            isSelected: selectedItemIndex == 0,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedItemIndex = 1;
            });
            widget.updateScreen(HomeScreen());
          },
          child: SideBarItem(
            name: "Statistique",
            icon: Icons.dashboard,
            isSelected: selectedItemIndex == 1,
          ),
        )
      ]),
    );
  }
}
