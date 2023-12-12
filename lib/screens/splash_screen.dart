import 'dart:async';
import 'dart:convert';

import 'package:fluter_nodejs_todo_app/avatars.dart';
import 'package:fluter_nodejs_todo_app/screens/login_screen.dart';
import 'package:fluter_nodejs_todo_app/screens/todo_list_screen.dart';
import 'package:fluter_nodejs_todo_app/sharedPreferenceManager/shared_prefernce_manager.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPrefernceManager _sharedPrefernceManager = SharedPrefernceManager();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    var token = await _sharedPrefernceManager.getDataSP('token');

    Timer(const Duration(seconds: 3), () {
      if (token == null) {
        // Handle the case where token is null (not retrieved from shared preferences)
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen();
        }));
      } else if (JwtDecoder.isExpired(token)) {
        // Handle the case where token is expired
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen();
        }));
      } else {
        // Token is valid, navigate to ToDoListScreen
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ToDoListScreen(token: token);
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(logo),
      ),
    );
  }
}
