import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();
  static LocalStorage? _instance;
  static LocalStorage get instance => _instance ??= LocalStorage._();

  static SharedPreferences? _sharedPreferences;
  SharedPreferences? get sharedPreferences => _sharedPreferences;

  // Get User Token
  static String? get userToken => _instance?.read('userToken');
  // Update User Token
  static Future<void> updateUserToken(String newToken) async =>
      await _instance!.write('userToken', newToken);

  // Get Is User First Time
  static bool get isFirstTime => _instance?.readBool('isFirstTime') ?? true;
  // Update Is User First Time
  static Future<void> updateIsFirstTime(bool isFirstTime) async =>
      await _instance!.writeBool('isFirstTime', isFirstTime);

// Get Is User Logged In
  static bool get isLoggedIn => _instance?.readBool('isLoggedIn') ?? false;
  // Update Is User Logged In
  static Future<void> updateLoginStatus(bool isLoggedIn) async =>
      await _instance!.writeBool('isLoggedIn', isLoggedIn);

  // logout user
  static Future<void> logout() async {
    await _instance!.erase();
    await updateIsFirstTime(false);
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> erase() async {
    await _sharedPreferences!.clear();
  }

  Future<void> remove(String key) async {
    await _sharedPreferences!.remove(key);
  }

  Future<void> write(String key, String? value) async {
    await _sharedPreferences!.setString(key, value ?? "");
  }

  Future<void> writeBool(String key, bool value) async {
    await _sharedPreferences!.setBool(key, value);
  }

  Future<void> writeInt(String key, int value) async {
    await _sharedPreferences!.setInt(key, value);
  }

  Future<void> writeDouble(String key, double value) async {
    await _sharedPreferences!.setDouble(key, value);
  }

  String? read(String key) => _sharedPreferences!.getString(key);
  bool? readBool(String key) => _sharedPreferences!.getBool(key);
  int? readInt(String key) => _sharedPreferences!.getInt(key);
  double? readDouble(String key) => _sharedPreferences!.getDouble(key);

  bool contains(String key) => _sharedPreferences!.containsKey(key);
}
