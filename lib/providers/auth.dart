import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  static const String API_KEY = "AIzaSyCYaPgSCi_6mtWvQxFtPgpY5IQS_Kle2Cg";

  String _token;
  DateTime _expiryDate;
  String _userID;

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
      _userID = responseData["localId"];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _sign("signUp", email, password);
  }

  Future<void> signIn(String email, String password) async {
    return _sign("signInWithPassword", email, password);
  }
}
