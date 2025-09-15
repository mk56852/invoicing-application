import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/presentation/tables/user_table.dart';
import 'package:management_app/presentation/widgets/screen_title.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const ScreenTitle(title: "Gérer les propriétaires"),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 540,
          child: UserTable(),
        ),
      ],
    );
  }
}
