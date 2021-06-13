import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:production_entry/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthModel extends ChangeNotifier {
  String errorMessage = "";

  bool _rememberMe = true;
  bool _stayLoggedIn = true;
  bool _useBio = false;
  User _user;

  User get user => _user;

  bool get rememberMe => _rememberMe;

  void handleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember_me", value);
      prefs.setBool("remember_me_toggle", value);
    });
  }

  bool get isBioSetup => _useBio;

  void handleIsBioSetup(bool value) {
    _useBio = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("use_bio", value);
    });
  }

  bool get stayLoggedIn => _stayLoggedIn;

  void handleStayLoggedIn(bool value) {
    _stayLoggedIn = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("stay_logged_in", value);
    });
  }

  void loadSettings() async {
    var _prefs = await SharedPreferences.getInstance();
    try {
      _useBio = _prefs.getBool("use_bio") ?? false;
    } catch (e) {
      print(e);
      _useBio = false;
    }
    try {
      _rememberMe = _prefs.getBool("remember_me") ?? false;
    } catch (e) {
      print(e);
      _rememberMe = false;
    }
    try {
      _stayLoggedIn = _prefs.getBool("stay_logged_in") ?? false;
    } catch (e) {
      print(e);
      _stayLoggedIn = false;
    }

    if (_stayLoggedIn) {
      User _savedUser;
      try {
        String _saved = _prefs.getString("schweppes_user_data");
        print("Saved: $_saved");
        _savedUser = User.fromJson(json.decode(_saved));
      } catch (e) {
        print("User Not Found: $e");
      }
      if (_useBio) {

        _user = _savedUser;
      }
    }
    notifyListeners();
  }

  Future<bool> login({
    @required User user,
  }) async {

    print("Logging In => "+user.user.name);


    // Get Info For User
    User _newUser = user;
    if (_newUser != null) {
      _user = _newUser;
      notifyListeners();

      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());
        print("Data: $_save");
        prefs.setString("schweppes_user_data", _save);
      });
    }

    return true;
  }


  Future<void> saveUserData(User user) async {
    if (user != null) {
      _user = user;
      notifyListeners();
      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());
        prefs.setString("schweppes_user_data", _save);

      });
    }
  }

  Future<void> logout() async {
    var _prefs = await SharedPreferences.getInstance();
    _useBio = _prefs.getBool("use_bio");
    _rememberMe = _prefs.getBool("remember_me");
    _user = null;
    print("Logout");
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("schweppes_user_data");
    });
    return;
  }
}
