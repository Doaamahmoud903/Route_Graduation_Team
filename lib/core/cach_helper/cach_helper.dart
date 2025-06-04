import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static final CacheHelper _instance = CacheHelper._internal();

  // Private constructor for Singleton pattern
  CacheHelper._internal();

  // Factory constructor to return the same instance
  factory CacheHelper() {
    return _instance;
  }

  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save simple data types using SharedPreferences
  Future<bool> saveData(String key, dynamic value) async {
    if (_prefs == null) {
      throw Exception('CacheHelper not initialized');
    }

    if (value is String) {
      return _prefs!.setString(key, value);
    } else if (value is int) {
      return _prefs!.setInt(key, value);
    } else if (value is bool) {
      return _prefs!.setBool(key, value);
    } else if (value is double) {
      return _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      return _prefs!.setStringList(key, value);
    } else {
      // For complex data types, use Hive
      var box = await Hive.openBox('complexDataBox');
      try {
        box.put(key, value);
        return true;
      } catch (e) {
        // Handle any exceptions
        print('Error saving data in Hive: $e');
        return false;
      } finally {
        await box.close();
      }
    }
  }

  // Open Hive Box
  Future<Box> _openBoxIfNeeded(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  // Retrieve data
  Future<dynamic> getData(String key) async {
    if (_prefs == null) {
      throw Exception('CacheHelper not initialized');
    }

    var value = _prefs!.get(key);
    if (value != null) {
      return value;
    } else {
      try {
        var box = await _openBoxIfNeeded('complexDataBox');
        return box.get(key);
      } catch (e) {
        print('Error retrieving data from Hive: $e');
        return null;
      }
    }
  }

  // Delete data
  Future<bool> removeData(String key) async {
    if (_prefs == null) {
      throw Exception('CacheHelper not initialized');
    }

    if (_prefs!.containsKey(key)) {
      return _prefs!.remove(key);
    } else {
      try {
        var box = await _openBoxIfNeeded('complexDataBox');
        if (box.containsKey(key)) {
          box.delete(key);
          return true;
        }
        return false;
      } catch (e) {
        print('Error deleting data from Hive: $e');
        return false;
      }
    }
  }
}
