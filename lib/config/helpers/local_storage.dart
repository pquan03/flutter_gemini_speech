import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _isFirstTime = 'isFirstTime';

  // Singleton

  LocalStorage._();

  static final LocalStorage _instance = LocalStorage._();

  factory LocalStorage() => _instance;

  late SharedPreferences _prefs;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  bool get isFirstTime => _prefs.getBool(_isFirstTime) ?? true;

  Future<void> setFirstTime(bool isFirstTime) async {
    await _prefs.setBool(_isFirstTime, isFirstTime);
  }
}
