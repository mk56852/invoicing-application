import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color fontColor;
  final double? height;
  final double? width;
  final Function onClick;
  const AppButton(
      {super.key,
      required this.text,
      required this.onClick,
      this.width,
      this.height,
      this.fontColor = Colors.white,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: fontColor),
          ),
        ),
      ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color fontColor;
  final double? height;
  final double? width;
  final Function onClick;
  final IconData? icon;
  const AppOutlinedButton(
      {super.key,
      required this.text,
      required this.onClick,
      this.width,
      this.height,
      this.icon,
      this.fontColor = Colors.black,
      this.borderColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10)),
        width: width,
        height: height,
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: fontColor,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: fontColor, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style:
                      TextStyle(color: fontColor, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final Function onClick;
  const AppIconButton(
      {super.key, required this.icon, this.color, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
