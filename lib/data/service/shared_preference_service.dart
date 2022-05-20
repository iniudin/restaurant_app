import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  static const dailyNotification = "DAILY_NOTIFICATION";

  Future<bool> get isDailyNotification async {
    final pref = await preferences;
    return pref.getBool(dailyNotification) ?? false;
  }

  void setDailyNotification(bool value) async {
    final sharedPref = await preferences;
    sharedPref.setBool(dailyNotification, value);
  }
}
