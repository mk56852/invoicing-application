import 'package:flutter/material.dart';
import 'package:management_app/presentation/screens/home_screen.dart';
import 'package:management_app/presentation/screens/users_screen.dart';
import 'package:management_app/presentation/widgets/sidebar_item.dart';
import 'package:management_app/utils/app_methods.dart';

class AppConfig {
  final AppColors lightColors;
  final AppColors darkColors;
  final SideBarMode sideBarMode;
  final List<SideBarItemDesc> sideBarItems;

  const AppConfig(
      {required this.lightColors,
      required this.darkColors,
      required this.sideBarMode,
      required this.sideBarItems});

  factory AppConfig.fromJson(Map<String, dynamic> data) {
    var lightC = AppColors.fromJson(data["LightColors"]);
    var darkC = AppColors.fromJson(data["DarkColors"]);
    var sideBarM = SideBarMode.values.byName(data["sideBarMode"]!);
    List<SideBarItemDesc> sideBarIt = (data["SideBarItems"]! as List<dynamic>)
        .map((item) => SideBarItemDesc(name: item))
        .toList();

    return AppConfig(
        lightColors: lightC,
        darkColors: darkC,
        sideBarMode: sideBarM,
        sideBarItems: sideBarIt);
  }

  @override
  String toString() {
    return "AppConfig >> LightColor: ${lightColors.toString()} \n DarkColor : ${darkColors.toString()} \n SideBarMode : ${sideBarMode.name} \n SideBarItems : ${sideBarItems.map((item) => item.name)}";
  }
}

class AppColors {
  final Color primayColor;
  final Color secondColor;
  final Color containerColor;
  final Color fontColor;
  final Color secondFontColor;
  final Color backgroundColor;

  const AppColors(
      {required this.primayColor,
      required this.secondColor,
      required this.containerColor,
      required this.fontColor,
      required this.secondFontColor,
      required this.backgroundColor});

  factory AppColors.fromJson(Map<String, dynamic> data) {
    return AppColors(
        primayColor: hexToColor(data["primaryColor"]!),
        secondColor: hexToColor(data["secondColor"]!),
        containerColor: hexToColor(data["containerColor"]!),
        fontColor: hexToColor(data["fontColor"]!),
        secondFontColor: hexToColor(data["secondFontColor"]!),
        backgroundColor: hexToColor(data["backgroundColor"]!));
  }

  @override
  String toString() {
    return "primary -> ${primayColor.toString()}";
  }
}

class SideBarItemDesc {
  final String name;

  const SideBarItemDesc({required this.name});

  factory SideBarItemDesc.fromJson(Map<String, String> data) {
    return SideBarItemDesc(name: data["name"]!);
  }

  Widget getScreen() {
    switch (name) {
      case "Home":
        return const HomeScreen();
      case "Users":
        return const UserScreen();
      default:
        return const HomeScreen();
    }
  }

  Widget getWidget() {
    switch (name) {
      case "Home":
        return const SideBarItem(name: "Dashboard", icon: Icons.home);
      case "Users":
        return const SideBarItem(name: "Users", icon: Icons.person);
      default:
        return const SideBarItem(name: "Dashboard", icon: Icons.home);
    }
  }
}

enum SideBarMode { expanded, small }
