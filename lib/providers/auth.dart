import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  static const String API_KEY = "AIzaSyCYaPgSCi_6mtWvQxFtPgpY5IQS_Kle2Cg";

  String _token;
  DateTime _expiryDate;
  String _userID;

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
      print(jsonDecode(response.body));
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    _sign("signUp", email, password);
  }

  Future<void> signIn(String email, String password) async {
    _sign("signInWithPassword", email, password);
  }
}
