import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  static const String API_KEY = "AIzaSyCYaPgSCi_6mtWvQxFtPgpY5IQS_Kle2Cg";

  String _token;
  DateTime _expiryDate;
  String _userID;
  Timer _autoLogoutTimer;

  bool get _isValidExpiryDate {
    return (_expiryDate != null) && (_expiryDate.isAfter(DateTime.now()));
  }

  bool get isAuth {
    return (_token != null);
  }

  String get token {
    if (_isValidExpiryDate && (_token != null)) {
      return _token;
    }
    return null;
  }

  String get userId {
    if (_isValidExpiryDate && (_userID != null)) {
      return _userID;
    }
    return null;
  }

  Future<void> _sign(String action, String email, String password) async {
    Uri url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:" +
        action +
        "?key=" +
        API_KEY);
    try {
      http.Response response = await http.post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = jsonDecode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));
      _autoLogout();
      _userID = responseData["localId"];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
          "userData",
          jsonEncode({
            "token": _token,
            "expiryDate": _expiryDate.toIso8601String(),
            "userID": _userID,
          }));
    } catch (error) {
      throw error;
    }
  }

  Future<bool> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userData")) {
      final userDataRaw = prefs.get("userData");
      final userData = jsonDecode(userDataRaw) as Map<String, Object>;
      final DateTime expiryDate = DateTime.parse(userData["expiryDate"]);
      if (expiryDate.isAfter(DateTime.now())) {
        _userID = userData["userID"];
        _expiryDate = expiryDate;
        _token = userData["token"];
        notifyListeners();
        _autoLogout();
        return true;
      }
    }
    return false;
  }

  Future<void> signUp(String email, String password) async {
    return _sign("signUp", email, password);
  }

  Future<void> signIn(String email, String password) async {
    return _sign("signInWithPassword", email, password);
  }

  void _resetAutoLogoutTimer() {
    if (_autoLogoutTimer != null) {
      _autoLogoutTimer.cancel();
      _autoLogoutTimer = null;
    }
  }

  Future<void> logOut() async {
    _resetAutoLogoutTimer();
    _token = null;
    _userID = null;
    _expiryDate = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    notifyListeners();
  }

  void xxx() {
    logOut();
  }

  void _autoLogout() {
    _resetAutoLogoutTimer();
    final x = _expiryDate.difference(DateTime.now()).inSeconds;
    _autoLogoutTimer = Timer(Duration(seconds: x), xxx);
  }
}
