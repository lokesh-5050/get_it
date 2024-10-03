import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // Private constructor for Singleton pattern
  SharedPrefs._privateConstructor();

  // Static instance of the class
  static final SharedPrefs _instance = SharedPrefs._privateConstructor();

  // Singleton getter
  static SharedPrefs get instance => _instance;

  // SharedPreferences instance
  SharedPreferences? _preferences;

  // Initialize SharedPreferences instance
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Set a value for a key (supports int, bool, double, String)
  Future<void> setKey(String key, dynamic value) async {
    if (_preferences == null) return;

    if (value is String) {
      await _preferences!.setString(key, value);
    } else if (value is int) {
      await _preferences!.setInt(key, value);
    } else if (value is bool) {
      await _preferences!.setBool(key, value);
    } else if (value is double) {
      await _preferences!.setDouble(key, value);
    } else {
      throw Exception("Invalid value type");
    }
  }

  dynamic getKey(String key) {
    if (_preferences == null) return null;
    return _preferences!.get(key);
  }

  Future<void> removeKey(String key) async {
    if (_preferences == null) return;
    await _preferences!.remove(key);
  }
}
