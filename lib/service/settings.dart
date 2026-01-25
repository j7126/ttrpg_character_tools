// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  late SharedPreferences prefs;

  static Future<SettingsService> build() async {
    SettingsService service = SettingsService();
    await service._setup();
    return service;
  }

  Future _setup() async {
    prefs = await SharedPreferences.getInstance();
    _readData();
  }

  void _readData() {
    var enablePlanechase = prefs.getBool('enablePlanechase');
    if (enablePlanechase != null) {
      _pref_enablePlanechase = enablePlanechase;
    }
  }

  bool _pref_enablePlanechase = false;
  bool get pref_enablePlanechase => _pref_enablePlanechase;
  set pref_enablePlanechase(bool val) {
    _pref_enablePlanechase = val;
    prefs.setBool('enablePlanechase', val);
  }
}
