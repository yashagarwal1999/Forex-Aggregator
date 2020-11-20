import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:http/http.dart' as http;

class Forex extends StatefulWidget {
  String symbs;
  Forex(final String c) {
    symbs = c;
  }
  @override
  _ForexListState createState() => _ForexListState();
}

class Provider {
  String name;
  String rating;
  double price;
  String info;
  Provider({this.name, this.rating, this.price, this.info});
}

class ChartData {
  ChartData(this.x, this.val1, this.val2);
  final DateTime x;
  final double val1;
  final double val2;
}

class _ForexListState extends State<Forex> {
  String c;
  String c1, c2;

  List<ChartData> data = [], pred_data = [];
  void getData() async {
    http.Response res = await http.get(
        "https://api.exchangeratesapi.io/history?start_at=2018-01-01&end_at=2018-01-11&symbols=" +
            c);

    Map data1 = json.decode(res.body)["rates"];
    print(data1);
    List<ChartData> da = [];
    data1.forEach((key, value) {
      da.add(ChartData(DateTime.parse(key), value[c1], value[c2]));
    });
    da.sort((x, y) {
      return x.x.compareTo(y.x);
    });
    if (data.length == 0) {
      setState(() {
        data = da;

        data.forEach((element) {
          pred_data.add(ChartData(
              element.x,
              (element.val1 + element.val1 / 100),
              (element.val2 + element.val2 / 100)));
        });
      });
    }
  }

  void gett() async {
    await getData();
  }

  List<Provider> forexproviders = [
    Provider(
        name: 'abcd',
        rating: 'Rating: ***',
        info:
            'A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.',
        price: 30.2),
    Provider(
        name: 'efgh',
        rating: 'Rating: ****',
        info:
            'A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.',
        price: 15.2),
    Provider(
        name: 'ijkl',
        rating: 'Rating: *****',
        info:
            'A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.',
        price: 35.2),
    Provider(
        name: 'adbc',
        rating: 'Rating: **',
        info:
            'A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.',
        price: 25.1),
    Provider(
        name: 'abbc',
        rating: 'Rating: ****',
        info:
            'A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.',
        price: 13.7)
  ];
  List<Provider> forexproviderstodisplay = new List<Provider>();
  var parameters = ['Price', 'Rating'];
  var currentitemselected = 'Price';

  @override
  void initState() {
    //  gett();
    setState(() {
      forexproviderstodisplay = forexproviders;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //c1 = widget.currs[0];
    //c2 = widget.currs[1];
    c = widget.symbs;
    c1 = c.split(',')[0];
    c2 = c.split(',')[1];
    gett();
    data.forEach((element) {
      print(element.x);
    });
    return Scaffold(
        appBar: AppBar(
          title: new Text("Forex Screen"),
          centerTitle: true,
          backgroundColor: Colors.blue[600],
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 450,
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                          name: "Date", dateFormat: DateFormat("dd-MM-yyyy")),
                      primaryYAxis: NumericAxis(),
                      legend: Legend(isVisible: true),
                      series: <ChartSeries>[
                        FastLineSeries<ChartData, DateTime>(
                            dataSource: data,
                            xValueMapper: (ChartData d, _) => d.x,
                            yValueMapper: (ChartData d, _) => d.val1,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            legendItemText: "Actual"),
                        FastLineSeries<ChartData, DateTime>(
                            dataSource: pred_data,
                            xValueMapper: (ChartData d, _) => d.x,
                            yValueMapper: (ChartData d, _) => d.val1,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            legendItemText: "Predicted"),
                      ],
                    ),
                  )
                ],
              ),
              Text("Performance"),
              Card(
                  child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("Today's High"),
                          Text("fdgh"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("Today's Low"),
                          Text("dvbnm"),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("Week's High"),
                          Text("fdgh"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("Week's Low"),
                          Text("dvbnm"),
                        ],
                      )
                    ],
                  ),
                ],
              )),
              Text("Forex Providers"),
              _searchBar(),
              SizedBox(
                height: 300,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: forexproviderstodisplay.length,
                    itemBuilder: (context, index) {
                      return _listProviders(index);
                    },
                  ),
                ),
              ),
              Text("sdfghjkvbghj"),
            ],
          ),
        ));
  }

  _searchBar() {
    return Row(children: <Widget>[
      //Padding(

      //padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      //
      //child:

      Expanded(
        flex: 9,
        child: TextField(
          decoration: InputDecoration(hintText: 'Search for Providers'),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              forexproviderstodisplay = forexproviders.where((element) {
                var providername = element.name.toLowerCase();
                return providername.contains(text);
              }).toList();
            });
          },
        ),
      ),

      _listParameters(),
    ]);
  }

  _listParameters() {
    return Expanded(
      flex: 1,
      child: DropdownButton<String>(
        items: parameters.map((String dropDownStringItems) {
          return DropdownMenuItem<String>(
            value: dropDownStringItems,
            child: Text(dropDownStringItems),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.currentitemselected = newValueSelected;
          });
        },
        value: currentitemselected,
      ),
    );
  }

  _listProviders(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: //GFAccordion(
          //    title: forexproviderstodisplay[index].name,
          //    content: forexproviderstodisplay[index].info,
          //    collapsedIcon: Icon(Icons.add),
          //    expandedIcon: Icon(Icons.minimize),

          //    ),
          Card(
        child: ListTile(
          title: Text(forexproviderstodisplay[index].name),
          subtitle: Column(
            children: <Widget>[
              Text(forexproviderstodisplay[index].info),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(forexproviderstodisplay[index].price.toString()),
                  Text(forexproviderstodisplay[index].rating),
                  TextButton(
                    child: const Text('BUY'),
                    onPressed: () {/* ... */},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
