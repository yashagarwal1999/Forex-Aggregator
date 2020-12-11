import 'dart:html' as html;
import 'package:flutter/material.dart';

class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  void initState() {
    html.window.localStorage["isLoggedIn"] = "false";
    html.window.localStorage["token"] = null;
    Future.delayed(
        Duration(seconds: 5), () => Navigator.pushNamed(context, '/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("Logged Out successfully...Redirecting to Login Page..."));
  }
}
