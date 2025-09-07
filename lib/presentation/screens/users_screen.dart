import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/presentation/tables/user_table.dart';
import 'package:management_app/presentation/widgets/add_user_modal.dart';
import 'package:management_app/presentation/widgets/app_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          children: [
            AppButton(
              text: "Add User",
              onClick: () => showMaterialModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => AddUserModal(ref: ref)),
              height: 50,
              width: 150,
            ),
            SizedBox(
              width: 5,
            ),
            AppButton(
              text: "Export pdf",
              onClick: print,
              height: 50,
              width: 150,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 500,
          child: UserTable(),
        ),
      ],
    );
  }
}
