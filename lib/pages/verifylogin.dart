import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'navigation.dart';
import 'package:forexaggregator/pages/constants.dart';
void  verifylogin(BuildContext context) async
{

     final html.Storage _localStorage = html.window.localStorage;
    var to = _localStorage['token'];
    var isL = _localStorage['isLoggedin'];
    http.Response res = await http.post(
        "https://wuhackathon.herokuapp.com/verify_login",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"isLoggedin": isL, "token": to}));

        Map data=json.decode(res.body);
        if(data["status"]==40)
        {
          Navigator.pushNamed(context, "/");
        }

}