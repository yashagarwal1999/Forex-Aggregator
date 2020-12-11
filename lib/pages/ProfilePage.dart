import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forexaggregator/pages/verifylogin.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'navigation.dart';
import 'package:forexaggregator/pages/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  Map data = {"name": " ", "mobile": " ", "email": " "};
  String name, mob, email;
  Future<void> getData() async {
    final html.Storage _localStorage = html.window.localStorage;
    var to = _localStorage['token'];
    var isL = _localStorage['isLoggedin'];
    http.Response res = await http.post(
        "https://wuhackathon.herokuapp.com/profile",
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
          name = data["name"];
          mob = data["mobile"];
          email = data["email"];
          load = ListView(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://www.teahub.io/photos/full/153-1536778_1920x1080-1440x9001280x800-navy-blue-gradient-background.jpg")),
                  ),
                  child: Column(
                    children: [
                      Navigation(),
                      Container(
                        width: double.infinity,
                        height: 350.0,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1189&q=80'),
                                radius: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              BootstrapCol(
                sizes: 'col-8',
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Contact Details:",
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        color: kPrimaryColor,
                        margin: EdgeInsets.symmetric(
                            horizontal: 48.0, vertical: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          title: Text(
                            email,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: kPrimaryColor,
                        margin: EdgeInsets.symmetric(
                            horizontal: 48.0, vertical: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          title: Text(
                            mob,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
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

  final FocusNode myFocusNode = FocusNode();

  Widget load = SpinKitCircle(
    color: Colors.blue,
  );

  Widget build(BuildContext context) {
    verifylogin(context);
    return Scaffold(body: load);
  }
}
