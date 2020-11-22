import 'dart:convert';
import 'dart:math';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'package:expandable/expandable.dart';

class Forex extends StatefulWidget {
  String c1, c2;
  double amount;
  Forex(final String x, final String y, final double am) {
    c1 = x;
    c2 = y;
    amount = am;
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
  ChartData(this.x, this.val1);
  final DateTime x;
  final double val1;
}

double getMax(List<ChartData> a) {
  double ans = 0;
  a.forEach((element) {
    ans = max(ans, element.val1);
  });
  return ans;
}

double getMin(List<ChartData> a) {
  double ans = 10000;
  a.forEach((element) {
    ans = min(ans, element.val1);
  });
  return ans;
}

class _ForexListState extends State<Forex> {
  String c1, c2;
  double leftPad = 0, rightPad = 0;
  double amount = 0,
      converted_amount = 0,
      highest_five = 0,
      highest_ten = 0,
      lowest_five = 0,
      lowest_ten = 0;
  List<ChartData> data = [], pred_data = [];
  void getData() async {
    String body = json.encode({"c1": c1, "c2": c2, "amount": amount});
    http.Response res = await http.post(
        "https://wuhackathon.herokuapp.com/convert",
        headers: {"Content-Type": "application/json"},
        body: body);
    Map data1 = json.decode(res.body);
    double temp = data1["data"]["converted_amount"], temp2, temp3, temp4, temp5;
    var prev_data = data1["data"]["prev_data"];
    List<ChartData> da = [];
    prev_data.forEach(
        (e) => {da.add(ChartData(DateTime.parse(e["date"]), e["value"]))});

    temp2 = getMax(da.sublist(0, min(da.length, 5)));
    temp3 = getMax(da.sublist(0, min(da.length, 10)));
    temp4 = getMin(da.sublist(0, min(da.length, 5)));
    temp5 = getMin(da.sublist(0, min(da.length, 10)));
    da.sort((x, y) {
      return x.x.compareTo(y.x);
    });
    if (data.length == 0) {
      setState(() {
        data = da;
        highest_five = temp2;
        highest_ten = temp3;
        lowest_five = temp4;
        lowest_ten = temp5;
        data.forEach((element) {
          pred_data
              .add(ChartData(element.x, (element.val1 + element.val1 / 100)));
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
  List<Widget> cardOfProviders = [];
  List<Provider> forexproviderstodisplay = new List<Provider>();
  var parameters = ['Price', 'Rating'];
  var currentitemselected = 'Price';

  @override
  void initState() {
    //  gett();
    setState(() {
      forexproviderstodisplay = forexproviders;
      forexproviderstodisplay.forEach((element) {
        cardOfProviders.add(Container(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: //GFAccordion(
              //    title: forexproviderstodisplay[index].name,
              //    content: forexproviderstodisplay[index].info,
              //    collapsedIcon: Icon(Icons.add),
              //    expandedIcon: Icon(Icons.minimize),

              //    ),
              Container(
            //   decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(              color: Colors.grey,
            // blurRadius: 5.0,
            // spreadRadius: 2.0,)
            //     ]
            //   ),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 2.0,
                    spreadRadius: 2,
                  ),
                ],
                color: Colors.white,
              ),
              child: ExpandablePanel(
                header: Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: Image(
                            alignment: Alignment.centerLeft,
                            image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2016/12/27/13/10/logo-1933884_960_720.png')),
                      ),
                      Expanded(
                        flex: 9,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                element.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text("Price:" + element.price.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text(element.rating,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ]),
                      ),
                    ]),
                  ),
                ),
                collapsed: Container(
                  padding: EdgeInsets.all(11),
                  child: Text(element.info,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                expanded: Container(
                  padding: EdgeInsets.all(11),
                  child: Text(
                    element.info,
                    softWrap: true,
                  ),
                ),
                tapHeaderToExpand: true,
                hasIcon: true,
              ),
            ),
          ),
        ));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //c1 = widget.currs[0];
    //c2 = widget.currs[1];
    c1 = widget.c1;
    c2 = widget.c2;
    amount = widget.amount;
    double width = MediaQuery.of(context).size.width;
    leftPad = (width < 1200) ? 0 : width / 6;
    rightPad = leftPad;
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
          top: true,
          maintainBottomViewPadding: true,
          child: Container(
            //margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
            color: Colors.blue[50],
            padding: EdgeInsets.fromLTRB(leftPad, 0, rightPad, 0),
            child: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  BootstrapRow(
                    height: 400,
                    children: [
                      BootstrapCol(
                        fit: FlexFit.tight,
                        sizes: 'col-lg-6 col-sm-12 col-md-12 col-xl-6',
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          height: 400,
                          child: SfCartesianChart(
                            primaryXAxis: DateTimeAxis(
                                name: "Date",
                                dateFormat: DateFormat("dd-MM-yyyy")),
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
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-lg-6 col-sm-12 col-md-12',
                        child: Padding(
                            padding: EdgeInsets.all(leftPad / 5),
                            child: Table(
                                //textDirection: TextDirection.LTR,
                                border: TableBorder(
                                    horizontalInside: BorderSide(
                                        width: 0.4,
                                        color: Colors.black,
                                        style: BorderStyle.solid),
                                    verticalInside: BorderSide.none,
                                    top: BorderSide(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.4),
                                    bottom: BorderSide(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.4)),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                // border: TableBorder.all(width: 1.5, color: kPrimaryColor),
                                children: [
                                  TableRow(children: [
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("")),
                                    Text(
                                      "Last 5 days",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Last 10 days",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Highest",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Text(
                                      highest_five.toString().substring(
                                          0,
                                          min(7,
                                              highest_five.toString().length)),
                                    ),
                                    Text(highest_ten.toString().substring(0,
                                        min(7, highest_five.toString().length)))
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("Lowest",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Text(lowest_five.toString().substring(
                                        0,
                                        min(7,
                                            highest_five.toString().length))),
                                    Text(lowest_ten.toString().substring(0,
                                        min(7, highest_five.toString().length)))
                                  ])
                                ])),
                      )
                    ],
                  ),
                  _searchBar(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: cardOfProviders,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _searchBar() {
    return Row(children: <Widget>[
      SizedBox(
        width: 10,
      ),
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
                cardOfProviders = [];
                forexproviderstodisplay.forEach((element) {
                  cardOfProviders.add(Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 4.0),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: //GFAccordion(
                        //    title: forexproviderstodisplay[index].name,
                        //    content: forexproviderstodisplay[index].info,
                        //    collapsedIcon: Icon(Icons.add),
                        //    expandedIcon: Icon(Icons.minimize),

                        //    ),
                        Container(
                      //   decoration: BoxDecoration(
                      //     boxShadow: [
                      //       BoxShadow(              color: Colors.grey,
                      // blurRadius: 5.0,
                      // spreadRadius: 2.0,)
                      //     ]
                      //   ),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 2.0,
                              spreadRadius: 2,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: ExpandablePanel(
                          header: Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(children: [
                                Expanded(
                                  flex: 1,
                                  child: Image(
                                      alignment: Alignment.centerLeft,
                                      image: AssetImage(
                                          '/home/daredevil/Hackathon/WUHackathon/forexaggregator/lib/assets/logo.png')),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          element.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                            "Price:" + element.price.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        Text(element.rating,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ]),
                                ),
                              ]),
                            ),
                          ),
                          collapsed: Container(
                            padding: EdgeInsets.all(11),
                            child: Text(element.info,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                          expanded: Container(
                            padding: EdgeInsets.all(11),
                            child: Text(
                              element.info,
                              softWrap: true,
                            ),
                          ),
                          tapHeaderToExpand: true,
                          hasIcon: true,
                        ),
                      ),
                    ),
                  ));
                });
              });
            }),
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
    print("hi");
  }
}
