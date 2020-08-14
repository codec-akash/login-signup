import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
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
    try {
      String url =
          "https://technicalbugs.com/cycle_app_apis/cycle_api_v1/cycle_app_mercent_api/merchent/register";
      var response = await http.post(
        url,
        body: json.encode(
          {
            "merchName": name,
            "merchEmail": email,
            "merchMobnum": phoneNumber,
            "merchPassword": password
          },
        ),
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
}
