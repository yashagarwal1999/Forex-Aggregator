import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forexaggregator/pages/verifylogin.dart';
import 'constants.dart';
import 'navigation.dart';
import 'providerscreen.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import "package:country_icons/country_icons.dart";
import "package:flag/flag.dart";
import 'package:dropdown_search/dropdown_search.dart';

class CurrencyRate {
  String currency;
  double rate;

  CurrencyRate(String c, double v) {
    currency = c;
    rate = v;
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List<String> dropdowncurrency = [
    "INR",
    "USD",
    "CAD",
    "JPY",
    "GBP",
    "CHF",
    "ZAR",
    "NZD",
    "HKD",
    "AUD",
    "RON"
  ];
  Map<String, String> Flags = {
    "INR": "in.png",
    "USD": "us.png",
    "EUR": "eu.png",
    "CAD": "ca.png",
    "JPY": "jp.png",
    "GBP": "gb.png",
    "CHF": "ch.png",
    "ZAR": "za.png",
    "NZD": "nz.png",
    "HKD": "hk.png",
    "AUD": "au.png",
    "RON": "ro.png"
  };

  String dropdownvalue1 = "INR";
  String dropdownvalue2 = "USD";
  String dropdownvalue3 = "INR";
  double FontSize = 20;
  String base = "INR";
  Widget loading1;
  double width123 = 20;
  double amount = 0;

  Map storeconversiondata = new Map();
  void getData() async {
    print("hello");
    // print(storeconversiondata[base]);
    if (storeconversiondata.isEmpty ||
        storeconversiondata.containsKey(base) == false) {
      http.Response res;
      if (base.compareTo("EUR") == 0) {
        res = await http.get('https://api.exchangeratesapi.io/latest?');
      } else {
        res = await http
            .get('https://api.exchangeratesapi.io/latest?base=' + base);
      }
      var data = json.decode(res.body)["rates"];
      if (base.compareTo("EUR") == 0) {
        data["EUR"] = 1.000;
      }
      print("Data=>" + base);
      print(data);
      // data.sort();
      //print(data);
      //This will change all the state variable
      setState(() {
        storeconversiondata[base] = data;
      });
      print(dropdowncurrency);
    }
  }

  void callgetDataAsync() async {
    await getData();
  }

  void call() async {
    await verifylogin(context);
  }

  @override
  void initState() {
    // TODO: implement initState

    call();
  }

  void sendData() {
    if (amount <= 0) {
      Alert(
              context: context,
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
              title: "Amount should be greater than 0.",
              type: AlertType.warning)
          .show();
    } else if (dropdownvalue1.compareTo(dropdownvalue2) != 0) {
      print("Value=>" + dropdownvalue1.compareTo(dropdownvalue2).toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Forex(dropdownvalue2, dropdownvalue1, amount)));
    } else {
      Alert(
              context: context,
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
              title: "Both the currencies cannot be same",
              type: AlertType.warning)
          .show();
    }
  }

  // Widget getDropDown1() {
  //   return new DropdownButton<String>(
  //     value: dropdownvalue1,
  //     items: dropdowncurrency.map((String curr) {
  //       return new DropdownMenuItem<String>(value: curr, child: new Text(curr));
  //     }).toList(),
  //     onChanged: (String newcurr) {
  //       setState(() {
  //         dropdownvalue1 = newcurr;
  //       });
  //     },
  //   );
  // }

  Widget getDropDown1() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: new DropdownSearch<String>(
        maxHeight: 450,
        // label: "Select Currency",
        mode: Mode.MENU,
        showSearchBox: true,
        showSelectedItem: true,
        items: dropdowncurrency,
        hint: "country in menu mode12",
        selectedItem: dropdownvalue1,
        onChanged: (String newcurr) {
          setState(() {
            dropdownvalue1 = newcurr;
          });
        },
      ),
    );
  }

  Widget getDropDown3() {
    return new DropdownSearch<String>(
        mode: Mode.MENU,
        maxHeight: 400,
        showSearchBox: true,
        showSelectedItem: true,
        items: dropdowncurrency,
        label: "Select Currency",
        hint: "country in menu mode",
        onChanged: (String newcurr) {
          setState(() {
            base = newcurr;
          });
        },
        selectedItem: base);
  }

  Widget getDropDown2() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: new DropdownSearch<String>(
        maxHeight: 450,
        mode: Mode.MENU,
        // label: "Select Currency",
        showSearchBox: true,
        showSelectedItem: true,
        items: dropdowncurrency,
        hint: "country in menu mode12",
        selectedItem: dropdownvalue2,
        onChanged: (String newcurr) {
          setState(() {
            dropdownvalue2 = newcurr;
          });
        },
      ),
    );
  }
  // Widget getDropDown3() {
  //   return new DropdownButton<String>(
  //     value: base,
  //     items: dropdowncurrency.map((String curr) {
  //       return new DropdownMenuItem<String>(
  //           value: curr, child: new Text(curr, style: TextStyle(fontSize: 20)));
  //     }).toList(),
  //     onChanged: (String newcurr) {
  //       setState(() {
  //         base = newcurr;
  //       });
  //     },
  //   );
  // }

  // Widget getDropDown2() {
  //   return new DropdownButton<String>(
  //     value: dropdownvalue2,
  //     items: dropdowncurrency.map((String curr) {
  //       return new DropdownMenuItem<String>(value: curr, child: new Text(curr));
  //     }).toList(),
  //     onChanged: (String newcurr) {
  //       setState(() {
  //         dropdownvalue2 = newcurr;
  //       });
  //     },
  //   );
  // }

  Widget createTopLossList(final CurrencyRate CURR) {
    String name = CURR.currency;
    String value = CURR.rate.toStringAsFixed(3);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      width: 200,
      child: Card(
        elevation: 10,
        // leading: Icon(Icons.album, size: 70),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    'icons/flags/png/' + Flags[base],
                    package: 'country_icons',
                    height: 35,
                    width: 35,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(base, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Icon(
              Icons.arrow_right_alt,
              color: Colors.blue[900],
              // image: NetworkImage(
              //     "https://cdn0.iconfinder.com/data/icons/feather/96/591276-arrow-right-512.png"),
              size: 40,
            ),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    'icons/flags/png/' + Flags[CURR.currency],
                    package: 'country_icons',
                    height: 35,
                    width: 35,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(CURR.currency,
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(width: 20),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double MediaHt = MediaQuery.of(context).size.height;
    loading1 = SpinKitCircle(
      color: kPrimaryColor,
    );
    callgetDataAsync();

    List<CurrencyRate> CurrencyApiRate = [];
    if (storeconversiondata.isNotEmpty &&
        storeconversiondata.containsKey(base)) {
      print("Yash");
      dropdowncurrency.forEach((element) {
        CurrencyApiRate.add(
            CurrencyRate(element, storeconversiondata[base][element]));
        // print(element + " " + storeconversiondata[base][element]);
      });
      CurrencyApiRate.sort((a, b) => a.rate.compareTo(b.rate));
      print("Sorrted");
      CurrencyApiRate.forEach((element) {
        print(element.rate);
      });
    }
    if (CurrencyApiRate.length > 0) {
      List<BootstrapCol> table = [];
      CurrencyApiRate.forEach((element) {
        table.add(BootstrapCol(
            sizes: 'col-sm-4 col-md-2 col-lg-2',
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'icons/flags/png/' + Flags[element.currency],
                      package: 'country_icons',
                      height: 35,
                      width: 35,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    element.currency,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    element.rate.toStringAsFixed(3),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ])));
      });
      loading1 = Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BootstrapCol(
                sizes: 'col-sm-12 col-md-10 col-lg-10',
                child: BootstrapRow(height: 60, children: [
                  BootstrapCol(
                      sizes: 'col-sm-12 col-md-2 col-lg-2',
                      child: Center(
                        child: Text("Get Conversion Rate for:",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      )),
                  BootstrapCol(
                      sizes: 'col-sm-12 col-md-2 col-lg-2',
                      child: getDropDown3()),
                  BootstrapCol(
                      sizes: 'col-sm-12 col-md-4 col-lg-4',
                      child: Column(
                        children: [
                          Text("Highest Conversion rate ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          createTopLossList(
                              CurrencyApiRate[CurrencyApiRate.length - 1]),
                          createTopLossList(
                              CurrencyApiRate[CurrencyApiRate.length - 2]),
                          createTopLossList(
                              CurrencyApiRate[CurrencyApiRate.length - 3]),
                        ],
                      )),
                  BootstrapCol(
                      sizes: 'col-sm-12 col-md-4 col-lg-4',
                      child: Column(
                        children: [
                          Text("Lowest Conversion rate ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          createTopLossList(CurrencyApiRate[0]),
                          createTopLossList(CurrencyApiRate[1]),
                          createTopLossList(CurrencyApiRate[2]),
                        ],
                      ))
                ]),
              ),
            ),
          ),
          BootstrapCol(
            sizes: 'col-sm-12 col-md-10 col-lg-10',
            child: BootstrapRow(height: 100, children: [
              BootstrapCol(
                  sizes: 'col-sm-12 col-md-12 col-lg-12',
                  child: Center(
                    child: Text("Currency Rates for Base: " + base,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  )),
              BootstrapCol(
                  sizes: 'col-sm-12 col-md-12 col-lg-12',
                  child: BootstrapRow(height: 50, children: table))
            ]),
          )
        ],
      );
    }
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          // color: HomePageColor, //change color
          // padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              BootstrapContainer(
                  fluid: true,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.yellow,
                              style: BorderStyle.solid,
                              width: 3)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://www.teahub.io/photos/full/153-1536778_1920x1080-1440x9001280x800-navy-blue-gradient-background.jpg"))),
                  children: [
                    Column(children: [
                      Navigation(),
                      BootstrapCol(
                        sizes: 'col-lg-10 col-sm-10 col-md-10',
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          padding: const EdgeInsets.fromLTRB(8, 70, 8, 0),
                          child: Center(
                            child: BootstrapCol(
                              sizes: 'col-sm-12 col-md-10 col-lg-10',
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0, MediaHt / 49, 0, 0),
                                child: BootstrapRow(
                                  height: 150,
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // Text(
                                    //   "From",
                                    //   style: TextStyle(fontSize: FontSize),
                                    // ),
                                    // SizedBox(width: width123),
                                    BootstrapCol(
                                      sizes: 'col-sm-12 col-md-2 col-lg-2',
                                      child: Container(
                                          width: 90, child: getDropDown1()),
                                    ),
                                    BootstrapCol(
                                      sizes: 'col-sm-12 col-md-2 col-lg-2',
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, MediaHt / 300.0, 0, 0),
                                        child: Icon(
                                          // width: 30,
                                          Icons.arrow_right_alt,
                                          color: Colors.white,
                                          // image: NetworkImage(
                                          //     "https://cdn2.iconfinder.com/data/icons/one-way/842/Arrow9-512.png"),

                                          size: 50,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: width123),

                                    // SizedBox(width: width123),
                                    BootstrapCol(
                                        sizes: 'col-sm-12 col-md-2 col-lg-2',
                                        child: Container(
                                            width: 90, child: getDropDown2())),

                                    BootstrapCol(
                                      sizes: 'col-sm-12 col-md-3 col-lg-3',
                                      child: Container(
                                        width: 170,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              color: Colors.grey,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Container(
                                          height: 45,
                                          margin: EdgeInsets.fromLTRB(
                                              0, MediaHt / 600, 0, 0),
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.black),
                                            onChanged: (val) {
                                              setState(() {
                                                amount = double.parse(val);
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Enter the amount'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: width123),
                                    BootstrapCol(
                                      sizes: 'col-sm-12 col-md-2 col-lg-2',
                                      child: Center(
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 4, 0, 0),
                                          child: RaisedButton(
                                            color: Colors.yellow,
                                            child: Icon(
                                              Icons
                                                  .keyboard_arrow_right_outlined,
                                              size: 40,
                                              color: Colors.blue[900],
                                              // image: NetworkImage(
                                              //     "https://cdn2.iconfinder.com/data/icons/one-way/842/Arrow9-512.png")
                                            ),
                                            onPressed: () {
                                              sendData();
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ]),
              SizedBox(height: 20),
              Column(
                children: [
                  loading1,
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
