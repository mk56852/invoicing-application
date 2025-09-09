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
        ScreenTitle(title: "Gérer les propriétaires"),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 540,
          child: UserTable(),
        ),
      ],
    );
  }
}
