import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forexaggregator/pages/constants.dart';
import 'package:http/http.dart' as http;
import 'navigation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget mainw = SpinKitRing(
      color: kPrimaryColor); //spinkit before loading and table after loading
  String base = "INR"; //base currency
  List<String> currencies = []; //List of all currencies

  //This function will change the table and base
  void getData() async {
    print("hello");
    http.Response res =
        await http.get('https://api.exchangeratesapi.io/latest?base=' + base);
    var data = json.decode(res.body)["rates"];
    //print(data);
    //This will change all the state variable
    setState(() {
      List<Widget> curr = [];
      List<Widget> values = [];
      currencies = [];
      data.forEach((k, v) => curr.add(Text(k)));
      data.forEach((k, v) => currencies.add(k));
      data.forEach((k, v) => values.add(Text(v.toString())));
      mainw = Table(
          textDirection: TextDirection.ltr,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(width: 1.5, color: kPrimaryColor),
          children: [TableRow(children: curr), TableRow(children: values)]);
    });
  }

  void gett() async {
    await getData();
  }

  @override
  void initState() {
    gett();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Navigation(),
                      mainw,
                      DropdownButton<String>(
                        value: base,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: kPrimaryColor),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            base = newValue;
                            gett();
                          });
                        },
                        items: currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ]))));
  }
}
