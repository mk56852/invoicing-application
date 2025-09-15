import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:management_app/models/setting.dart';
import 'package:path_provider/path_provider.dart';

class ConfigService {
  static const String _fileName = "config.json";

  Future<File> _getConfigFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$_fileName");
  }

  Future<Setting> loadConfig() async {
    final file = await _getConfigFile();

    if (await file.exists()) {
      final content = await file.readAsString();
      return Setting.fromJson(jsonDecode(content));
    } else {
      // load default config from assets (optional)
      final defaultContent = await rootBundle.loadString("assets/$_fileName");
      await file.writeAsString(defaultContent);
      return Setting.fromJson(jsonDecode(defaultContent));
    }
  }

  Future<void> saveConfig(Setting setting) async {
    final file = await _getConfigFile();
    await file.writeAsString(jsonEncode(setting.toJson()));
  }
}
