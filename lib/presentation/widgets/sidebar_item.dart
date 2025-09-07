import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  IconData icon;
  String name;
  bool isSelected;
  SideBarItem(
      {super.key,
      required this.name,
      required this.icon,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : null,
        borderRadius: BorderRadius.circular(7),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              child: Icon(
            icon,
            color: isSelected ? Colors.black : Colors.white,
            size: 25,
          )),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.black : Colors.white,
            ),
            overflow: TextOverflow.visible,
          ))
        ],
      ),
    );
  }
}
