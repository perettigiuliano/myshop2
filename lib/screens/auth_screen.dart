import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myshop2/models/http_exception.dart';
import 'package:myshop2/providers/auth.dart';
import 'package:myshop2/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const ROUTE = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 150, 0, 0.9),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 40.0,
                      ),
                      transform: Matrix4.rotationZ(-0.2)..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        border: Border.all(color: Colors.yellow, width: 2),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black45,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'S h o p p i s s i m o'.toUpperCase(),
                        style: TextStyle(
                          color:
                              Theme.of(context).accentTextTheme.headline6.color,
                          fontSize: 38,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Size> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _ShowDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Something went wrong",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    var errorMessage = "";
    try {
      switch (_authMode) {
        case AuthMode.Login:
          await Provider.of<Auth>(context, listen: false).signIn(
            _authData["email"],
            _authData["password"],
          );
          break;
        case AuthMode.Signup:
          await Provider.of<Auth>(context, listen: false).signUp(
            _authData["email"],
            _authData["password"],
          );
          break;
      }
    } on HttpException catch (error) {
      errorMessage =
          (_authMode == AuthMode.Login ? "Login failed" : "SignUp failed");
      switch (_authMode) {
        case AuthMode.Signup:
          if (error.toString().contains("EMAIL_EXISTS")) {
            errorMessage =
                "The email address is already in use by another account";
          }
          if (error.toString().contains("OPERATION_NOT_ALLOWED")) {
            errorMessage = "Password sign-in is disabled for this project";
          }
          if (error.toString().contains("TOO_MANY_ATTEMPTS_TRY_LATER")) {
            errorMessage =
                "We have blocked all requests from this device due to unusual activity. Try again later";
          }
          break;
        case AuthMode.Login:
          if (error.toString().contains("EMAIL_NOT_FOUND")) {
            errorMessage =
                "There is no user record corresponding to this identifier. The user may have been deleted";
          }
          if (error.toString().contains("INVALID_PASSWORD")) {
            errorMessage =
                "The password is invalid or the user does not have a password";
          }
          if (error.toString().contains("USER_DISABLED")) {
            errorMessage =
                "The user account has been disabled by an administrator";
          }
          if (error.toString().contains("TOO_MANY_ATTEMPTS_TRY_LATER")) {
            errorMessage =
                "We have blocked all requests from this device due to unusual activity. Try again later";
          }
          break;
      }
    } catch (error) {
      errorMessage = "Could not authenticate";
    }
    setState(() {
      _isLoading = false;
    });
    if (errorMessage.length > 0) {
      _ShowDialog(errorMessage);
    }
  }

  void _switchAuthMode() {
    switch (_authMode) {
      case AuthMode.Login:
        setState(() {
          _authMode = AuthMode.Signup;
        });
        _controller.forward();
        break;
      case AuthMode.Signup:
        setState(() {
          _authMode = AuthMode.Login;
        });
        _controller.reverse();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        // height: _authMode == AuthMode.Signup ? 320 : 260,
        height: _heightAnimation.value.height,
        constraints:
            // BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
            BoxConstraints(minHeight: _heightAnimation.value.height),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
