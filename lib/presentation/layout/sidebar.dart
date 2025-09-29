import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management_app/configuration/app_config.dart';
import 'package:management_app/presentation/providers/setting_data_provider.dart';
import 'package:management_app/presentation/screens/profil_screen.dart';
import 'package:management_app/presentation/screens/users_screen.dart';
import 'package:management_app/presentation/widgets/sidebar_item.dart';
import 'package:management_app/utils/contact_info.dart';

class SideBar extends ConsumerStatefulWidget {
  final Function updateScreen;
  const SideBar({super.key, required this.updateScreen});

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    String name = ref.watch(settingNotifierProvider).getFullName();
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
        minWidth: 300,
      ),
      height: double.maxFinite,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: SimpleAppColors.blueColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "Maitre",
          style: GoogleFonts.dancingScript(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          name,
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
            widget.updateScreen(ProfilScreen());
          },
          child: SideBarItem(
            name: "Profile",
            icon: Icons.dashboard,
            isSelected: selectedItemIndex == 1,
          ),
        ),
        Spacer(),
        SizedBox(
          height: 120,
          child: ContactInfo(),
        )
      ]),
    );
  }
}
