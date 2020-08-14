import 'package:MasterCycle/providers/auth.dart';
import 'package:MasterCycle/providers/merchant.dart';
import 'package:MasterCycle/screens/home_screen.dart';
import 'package:MasterCycle/screens/login_screen.dart';
import 'package:MasterCycle/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, value, child) => MaterialApp(
          title: "MasterCycle",
          home: LoginScreen(),
          routes: {
            HomePage.routeName: (ctx) => HomePage(),
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
