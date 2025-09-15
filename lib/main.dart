import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/database/database.dart';
import 'package:management_app/models/setting.dart';
import 'package:management_app/presentation/layout/app_layout.dart';
import 'package:management_app/presentation/layout/sidebar.dart';
import 'package:management_app/presentation/providers/setting_data_provider.dart';
import 'package:management_app/presentation/screens/users_screen.dart';
import 'package:management_app/utils/config_service.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      titleBarStyle: TitleBarStyle.normal, title: "Facturation V1");

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.maximize();
    await windowManager.setFullScreen(false); // make window fullscreen
    await windowManager.setResizable(false); // prevent resizing
    await windowManager.setMaximizable(true); // prevent maximize button
    await windowManager.setMinimizable(true); // prevent minimize button
    await windowManager.show();
    await windowManager.focus();
  });

  ConfigService service = ConfigService();
  Setting setting = await service.loadConfig();
  AppDatabase.db = AppDatabase.fromPath(setting.dbDirectory);
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Widget currentScreen = UserScreen();

  @override
  Widget build(BuildContext context) {
    ref.read(settingNotifierProvider.notifier).load();
    return MaterialApp(
      home: Scaffold(
          body: AppLayout(
              body: currentScreen,
              menuBar: Container(
                height: 25,
              ),
              sideBar: SideBar(
                updateScreen: (screen) => setState(() {
                  currentScreen = screen;
                }),
              ))),
    );
  }
}
