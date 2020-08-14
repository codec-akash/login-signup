import 'package:flutter/material.dart';

class Merchant extends ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final double lat1;
  final double lat2;
  final double lon1;
  final double lon2;

  Merchant({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.phoneNumber,
    this.lat1,
    this.lat2,
    this.lon1,
    this.lon2,
  });
}
