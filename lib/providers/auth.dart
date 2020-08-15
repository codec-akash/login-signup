import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String _token;
  int _userId;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  int get userId {
    return _userId;
  }

  Future<void> signup(
    String name,
    String email,
    String phoneNumber,
    String password,
  ) async {
    print(password);
    print(email);
    print(phoneNumber);
    print(name);
    var data = jsonEncode(
      {
        "merchName": name,
        "merchEmail": email,
        "merchMobnum": phoneNumber,
        "merchPassword": password
      },
    );
    print(data);
    try {
      String url =
          "https://technicalbugs.com/cycle_app_apis/cycle_api_v1/cycle_app_mercent_api/merchent/register";
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data,
      );
      print(response);

      final responseData = json.decode(response.body);
      print(responseData);
      print("object");
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> login(String username, String password) async {
    String url =
        "https://technicalbugs.com/cycle_app_apis/cycle_api_v1/cycle_app_mercent_api/merchent/login";
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'inputlogin': username,
            'merchPassword': password,
          },
        ),
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      _token = responseData['token'];
      _userId = responseData['results']['id'];
      print(_token + " " + _userId.toString());
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
        },
      );
      prefs.setString("vendor", userData);
    } catch (error) {
      print(error);
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('vendor')) {
      return false;
    }
    final extratedVendor =
        json.decode(prefs.getString("vendor")) as Map<String, Object>;
    _token = extratedVendor['token'];
    _userId = extratedVendor['userId'];
    print(_userId);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
