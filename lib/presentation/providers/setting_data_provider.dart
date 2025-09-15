import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/models/setting.dart';
import 'package:management_app/utils/config_service.dart';

class SettingNotifier extends StateNotifier<Setting> {
  final ConfigService service;
  SettingNotifier(this.service) : super(Setting.empty());
  SettingNotifier.fromExisting(super.setting, this.service);

  Future<void> update(Setting setting) async {
    await service.saveConfig(setting);
    state = setting;
  }

  void updateStateWithExisting(Setting setting) {
    state = setting;
  }

  Future<void> load() async {
    Setting setting = await service.loadConfig();
    state = setting;
  }

  Future<void> exportFacture() async {
    Setting setting = state;
    setting.factureNumber = setting.factureNumber + 1;
    await update(setting);
  }
}

StateNotifierProvider<SettingNotifier, Setting> settingNotifierProvider =
    StateNotifierProvider<SettingNotifier, Setting>(
        (ref) => SettingNotifier(ConfigService()));
