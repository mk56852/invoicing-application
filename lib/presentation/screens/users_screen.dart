import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management_app/presentation/tables/user_table.dart';
import 'package:management_app/presentation/widgets/add_user_modal.dart';
import 'package:management_app/presentation/widgets/app_button.dart';
import 'package:management_app/presentation/widgets/screen_title.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ScreenTitle(title: "Gérer les propriétaires"),
            ),
            Flexible(
              child: Wrap(
                children: [
                  AppOutlinedButton(
                    text: "Ajouter propriétaire",
                    icon: Icons.person_add,
                    onClick: () => showMaterialModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => AddUserModal(ref: ref)),
                    height: 50,
                    width: 200,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  AppOutlinedButton(
                    text: "Exporter pdf",
                    icon: Icons.download,
                    onClick: print,
                    height: 50,
                    width: 180,
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 540,
          child: UserTable(),
        ),
      ],
    );
  }
}
