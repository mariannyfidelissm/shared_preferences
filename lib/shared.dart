import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<String?> readBackground() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("background");
  }

  Future<bool> saveBackground(String image) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("background", image);
  }

  removeBackground(String image) async {
    final prefs = await SharedPreferences.getInstance();
    bool res = await prefs.remove("background");
    return res;
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) {
      return null;
    } else {
      return prefs.getString(key);
    }
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    //debugPrint(prefs.getString(key));
    //debugPrint(json.encode(prefs.getString(key)));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
