import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'navigation.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map data = {"name": " ", "mobile": " ", "email": " "};

  Future<void> getData() async {
    final html.Storage _localStorage = html.window.localStorage;
    var to = _localStorage['token'];
    var isL = _localStorage['isLoggedin'];
    http.Response res = await http.post("http://localhost:8007/profile",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"isLoggedin": isL, "token": to}));
    var data1 = json.decode(res.body);
    print(data1);
    if (data1["status"] == 40) {
      Navigator.pushNamed(context, '/');
    } else {
      if (!data1["isVerified"]) {
        Navigator.pushNamed(context, '/verify');
      }
      //print(data1["data"].runtimeType);
      else {
        setState(() {
          data = data1["data"];
        });
      }
    }
  }

  void gett() async {
    await getData();
  }

  @override
  void initState() {
    gett();
    super.initState();

    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Navigation(),
              CircleAvatar(
                radius: 60.0,
                //backgroundImage: AssetImage('images/profile-high.jpg'),
              ),
              Text(
                data["name"],
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 200.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal.shade400,
                  ),
                  title: Text(
                    data["mobile"],
                    style: TextStyle(
                      color: Colors.teal.shade400,
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal.shade400,
                  ),
                  title: Text(
                    data["email"],
                    style: TextStyle(
                      color: Colors.teal.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
