import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/presentation/layout/app_layout.dart';
import 'package:management_app/presentation/layout/sidebar.dart';
import 'package:management_app/presentation/screens/users_screen.dart';

void main() async {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: AppLayout(
              body: UserScreen(),
              menuBar: Container(
                height: 50,
              ),
              sideBar: const SideBar())),
    );
  }
}
