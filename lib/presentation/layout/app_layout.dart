import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget body;
  final Widget sideBar;
  final Widget menuBar;
  const AppLayout(
      {super.key,
      required this.body,
      required this.menuBar,
      required this.sideBar});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sideBar,
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                menuBar,
                const SizedBox(
                  height: 15,
                ),
                body
              ],
            ),
          ),
        ))
      ],
    );
  }
}
