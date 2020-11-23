import 'dart:convert';
import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Forex extends StatefulWidget {
  String c1, c2;
  Forex(final String x, final String y) {
    c1 = y;
    c2 = x;
  }
  @override
  _ForexListState createState() => _ForexListState();
}

class Provider {
  String name;
  String rating;
  double price;
  String info;
  String link;
  Provider({this.name, this.rating, this.price, this.info, this.link});
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
  String sea = '';
  double rate = 0;
  String sortingCat = "Price";
  Widget mainW = SpinKitCircle(
    color: kPrimaryColor,
  );
  double amount = 1,
      converted_amount = 0,
      highest_five = 0,
      highest_ten = 0,
      lowest_five = 0,
      lowest_ten = 0;
  List<Provider> forexproviders = [];
  List<ChartData> data = [], pred_data = [];
  void getData() async {
    String body = json.encode({"c1": c1, "c2": c2});
    http.Response res = await http.post("http://localhost:8500/convert",
        headers: {"Content-Type": "application/json"}, body: body);
    String b1 = json.encode({"amount": amount});
    http.Response res1 = await http.post(
        "http://localhost:8500/getallproviders",
        headers: {"Content-Type": "application/json"},
        body: b1);
    Map data1 = json.decode(res.body);
    Map data2 = json.decode(res1.body);
    print(data1);
    double temp = data1["data"]["rate"], temp2, temp3, temp4, temp5;
    var provider_data = data2["provider_data"];
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
    setState(() {
      rate = temp;
      provider_data.forEach((e) => {
            forexproviders.add(Provider(
                name: e["name"],
                rating: e["rating"].toString(),
                price: (e["amount"] + 1) * rate,
                info: e["info"],
                link: e["link"]))
          });
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

  void gett() async {
    await getData();
  }

  List<Widget> cardOfProviders = [];
  List<Provider> forexproviderstodisplay = [];
  var parameters = ['Price', 'Rating'];
  var currentitemselected = 'Price';

  @override
  void initState() {
    //  gett();
    //   print(forexproviders);
    // setState(() {

    // });

    super.initState();
  }

  void printF() {
    forexproviders.forEach((element) {
      print(element.price.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    //c1 = widget.currs[0];
    //c2 = widget.currs[1];
    c1 = widget.c1;
    c2 = widget.c2;
    double width = MediaQuery.of(context).size.width;
    leftPad = (width < 1200) ? 0 : width / 6;
    rightPad = leftPad;
    if (data.length == 0 && forexproviders.length == 0) {
      gett();
    }
    // forexproviderstodisplay = forexproviders;
    forexproviderstodisplay = [];
    for (var i = 0; i < forexproviders.length; i++) {
      if (forexproviders[i].name.toLowerCase().contains(sea))
        forexproviderstodisplay.add(Provider(
            name: forexproviders[i].name,
            rating: forexproviders[i].rating,
            price: forexproviders[i].price,
            info: forexproviders[i].info,
            link: forexproviders[i].link));
    }
    printF();
    for (var i = 0; i < forexproviderstodisplay.length; i++) {
      forexproviderstodisplay[i].price *= amount;
    }
    cardOfProviders = [];
    if (sortingCat == "Price")
      forexproviderstodisplay.sort((x, y) => x.price.compareTo(y.price));
    else if (sortingCat == "Rating")
      forexproviderstodisplay.sort((x, y) => x.rating.compareTo(y.rating));
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
                          image: NetworkImage(element.link)),
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
                            Text("Price:" + element.price.toStringAsFixed(2),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {},
                                starCount: 5,
                                rating: double.parse(element.rating),
                                size: 30.0,
                                isReadOnly: true,
                                color: Colors.green,
                                borderColor: Colors.green,
                                spacing: 0.0)
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
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(11),
                        child: Text(
                          element.info,
                          softWrap: true,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.blue,
                        child: Text(
                          "Visit..",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]),
              ),
              tapHeaderToExpand: true,
              hasIcon: true,
            ),
          ),
        ),
      ));
    });
    if (data.length != 0 && forexproviders.length != 0) {
      mainW = Container(
        //margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
        color: Colors.blue[50],
        padding: EdgeInsets.fromLTRB(leftPad, 0, rightPad, 0),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
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
                            name: "Date", dateFormat: DateFormat("dd-MM-yyyy")),
                        primaryYAxis: NumericAxis(),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          FastLineSeries<ChartData, DateTime>(
                              dataSource: data,
                              xValueMapper: (ChartData d, _) => d.x,
                              yValueMapper: (ChartData d, _) => d.val1,
                              legendItemText: "Actual"),
                          FastLineSeries<ChartData, DateTime>(
                              dataSource: pred_data,
                              xValueMapper: (ChartData d, _) => d.x,
                              yValueMapper: (ChartData d, _) => d.val1,
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Last 10 days",
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  highest_five.toString().substring(0,
                                      min(7, highest_five.toString().length)),
                                ),
                                Text(highest_ten.toString().substring(
                                    0, min(7, highest_five.toString().length)))
                              ]),
                              TableRow(children: [
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text("Lowest",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Text(lowest_five.toString().substring(
                                    0, min(7, highest_five.toString().length))),
                                Text(lowest_ten.toString().substring(
                                    0, min(7, highest_five.toString().length)))
                              ])
                            ])),
                  )
                ],
              ),
              BootstrapCol(
                sizes: 'col-lg-6 col-sm-12 col-md-12',
                child: Card(
                  color: kPrimaryColor,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(rightPad / 10),
                    child: BootstrapRow(height: 30, children: [
                      BootstrapCol(
                        sizes: 'col-lg-3 col-md-12 col-sm-12',
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextFormField(
                            initialValue: "1",
                            textAlign: TextAlign.center,
                            onChanged: (val) => {
                              setState(() {
                                amount = double.parse(val);
                              })
                            },
                          ),
                        ),
                      ),
                      BootstrapCol(
                          sizes: 'col-lg-3 col-md-4 col-sm-4',
                          child: Card(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextFormField(
                              initialValue: c1,
                              enabled: false,
                              textAlign: TextAlign.center,
                            ),
                          )),
                      BootstrapCol(
                          sizes: 'col-lg-2 col-sm-2 col-md-2',
                          child: Image(
                              height: 40,
                              color: Colors.white,
                              image: NetworkImage(
                                  "https://cdn2.iconfinder.com/data/icons/one-way/842/Arrow9-512.png"))),
                      BootstrapCol(
                          sizes: 'col-lg-3 col-md-4 col-sm-4',
                          child: Card(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextFormField(
                              initialValue: c2,
                              textAlign: TextAlign.center,
                              enabled: false,
                            ),
                          )),
                    ]),
                  ),
                ),
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
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: new Text("Forex Screen"),
          centerTitle: true,
          backgroundColor: Colors.blue[600],
        ),
        body:
            SafeArea(top: true, maintainBottomViewPadding: true, child: mainW));
  }

  _searchBar() {
    return BootstrapCol(
      sizes: 'col-lg-12 col-sm-12 col-md-12',
      child: BootstrapRow(height: 40, children: [
        BootstrapCol(
          sizes: 'col-lg-8 col-sm-8 col-md-8',
          child: TextField(
              decoration: InputDecoration(hintText: 'Search for Providers'),
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  sea = text;
                });
              }),
        ),
        BootstrapCol(
            sizes: 'col-lg-3 col-sm-3 col-md-3', child: _listParameters()),
      ]),
    );
  }

  _listParameters() {
    return DropdownButton<String>(
      isExpanded: false,
      items: parameters.map((String dropDownStringItems) {
        return DropdownMenuItem<String>(
          value: dropDownStringItems,
          child: Text(dropDownStringItems),
        );
      }).toList(),
      onChanged: (String newValueSelected) {
        setState(() {
          this.currentitemselected = newValueSelected;
          sortingCat = newValueSelected;
        });
      },
      value: currentitemselected,
    );
  }

  _listProviders(index) {
    print("hi");
  }
}
