import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  final IconData icon;
  final String name;
  const SideBarItem({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Icon(icon)),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: Text(
          name,
          overflow: TextOverflow.visible,
        ))
      ],
    );
  }
}
