import 'package:shared_preferences/shared_preferences.dart';

class SingleTon {
  factory SingleTon() {
    return singleTonStaticConstructor;
  }

  late SharedPreferences _sharedPreferences;

  static SingleTon singleTonStaticConstructor = SingleTon.initialize();

  SingleTon.initialize();

  initialize() async {
    await SharedPreferences.getInstance()
        .then((instance) => this._sharedPreferences = instance);
  }

  bool isLoggedIn() => _sharedPreferences.getBool("loggedIn") ?? false;


  setLogin(bool loggedIn) async {
    await _sharedPreferences.clear();
    await _sharedPreferences.setBool("loggedIn", loggedIn);
  }

  isApproved() => _sharedPreferences.getBool("sellerApproved") ?? false;

  String getStringValue(String key) => _sharedPreferences.getString(key) ?? "";

  setStringValue(String key, String value) async =>
      await _sharedPreferences.setString(key, value);
}
