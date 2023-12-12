import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernceManager {
  void addDatatoSP(String key, String value) async {
    final pref1 = await SharedPreferences.getInstance();
    pref1.setString(key, value);
  }

  getDataSP(String key) async {
    final pref1 = await SharedPreferences.getInstance();
    String? value = pref1.getString(key);
    return value;
  }

  removeDataSP(String key) async {
    final pref1 = await SharedPreferences.getInstance();
    pref1.remove(key);
  }
}
