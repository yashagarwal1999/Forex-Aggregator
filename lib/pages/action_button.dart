import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forexaggregator/pages/constants.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showAlert(BuildContext context, String value) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: value,
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        color: kPrimaryColor,
        onPressed: () {
          Navigator.pop(context);
        },
        width: 180,
      )
    ],
  ).show();
}

Widget temp;
void request(BuildContext context, String text, bool flag, String email,
    String pass, String mobile, String name) async {
  Alert(
    context: context,
    title: 'Loading...',
    style: AlertStyle(isButtonVisible: false, isCloseButton: false),
    content: SpinKitRing(
      color: kPrimaryColor,
    ),
  ).show();
  if (flag) {
    if (email == null) {
      Navigator.pop(context);
      Alert(
        context: context,
        type: AlertType.warning,
        title: 'Invalid Input!',
        desc: "Email cannot be empty!",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: kPrimaryColor,
            onPressed: () => Navigator.pop(context),
            width: 180,
          )
        ],
      ).show();
    } else {
      Map object = {"email": email, "plainPassword": pass};
      String body = json.encode(object);
      http.Response res = await http.post(
        "https://wuhackathon.herokuapp.com/login",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      Navigator.pop(context);
      var data = json.decode(res.body);
      // print(data);
      if (data["status"] == 300) {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Invalid Credentials!',
          desc: "Email and password do not match!",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: kPrimaryColor,
              onPressed: () => Navigator.pop(context),
              width: 180,
            )
          ],
        ).show();
      } else {
        String token = data["data"]["token"];
        final html.Storage _localStorage = html.window.localStorage;
        _localStorage['token'] = token;
        _localStorage['isLoggedin'] = "true";
        Alert(
          context: context,
          style: AlertStyle(
            isCloseButton: false,
            isButtonVisible: false,
          ),
          type: AlertType.success,
          title: 'Login Successful',
        ).show();
        Future.delayed(const Duration(milliseconds: 5000), () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/profile');
        });
      }
    }
  } else {
    Map object = {
      "email": email,
      "name": name,
      "mobile": mobile,
      "plainPassword": pass
    };
    String body = json.encode(object);
    //print(body);
    http.Response res = await http.post(
      "https://wuhackathon.herokuapp.com/signup",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    Navigator.pop(context);
    var data = json.decode(res.body);
    // print(data);
    int status = data["status"];
    switch (status) {
      case 10:
        showAlert(context, "Email format is invalid!");
        break;
      case 20:
        showAlert(context, "Password is too small");
        break;
      case 30:
        showAlert(context, "Mobile no. is invalid");
        break;
      case 50:
        showAlert(context, "Mobile no already in use");
        break;
      case 100:
        showAlert(context, "User already exists");
        break;
      case 200:
        Alert(
                context: context,
                type: AlertType.success,
                title: 'Registration Successful',
                desc: "Please verify your email...",
                style: AlertStyle(isButtonVisible: false, isCloseButton: false))
            .show();
        Future.delayed(const Duration(milliseconds: 5000), () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/');
        });
        break;
      default:
        showAlert(context, "Email format is invalid!");
        break;
    }
  }
}

Widget actionButton(BuildContext context, String text, bool flag, String email,
    String password, String mobile, String name) {
  temp = Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
  return RaisedButton(
    onPressed: () {
      request(context, text, flag, email, password, mobile, name);
    },
    color: kPrimaryColor,
    padding: const EdgeInsets.all(25.0),
    child: Center(
      child: temp,
    ),
  );
}
