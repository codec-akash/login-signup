import 'package:MasterCycle/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/sign-up";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameFocus = FocusNode();
  final _phoneNumber = FocusNode();
  final _passWord = FocusNode();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'phoneNumber': '',
    'password': '',
  };

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_authData.toString());
    await Provider.of<Auth>(context, listen: false).signup(
      _authData['name'],
      _authData['email'],
      _authData['phoneNumber'],
      _authData['password'],
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _authData['email'] = newValue;
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_nameFocus);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter a valid Name";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _authData['name'] = newValue;
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_phoneNumber);
                },
                focusNode: _nameFocus,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "PhoneNumber",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                focusNode: _phoneNumber,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty || value.length != 10) {
                    return "Invalid Phone Number";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _authData['phoneNumber'] = newValue;
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_passWord);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty || value.length <= 8) {
                    return "Enter a valid password";
                  }
                  return null;
                },
                focusNode: _passWord,
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  _authData['password'] = newValue;
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus();
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm-Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) => _saveForm(),
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      onPressed: _saveForm,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
