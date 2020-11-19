import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:highlight_text/highlight_text.dart';

class Forex extends StatefulWidget {
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
  ChartData(this.x, this.open, this.high, this.low, this.close);
  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;
}

class _ForexListState extends State<Forex> {
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

  List<ChartData> data = [
    ChartData(DateTime(2016, 01, 11), 90.97, 101.19, 95.36, 97.13),
    ChartData(DateTime(2016, 01, 25), 101.97, 101.19, 92.36, 94.02),
    ChartData(DateTime(2016, 01, 27), 84.97, 91.19, 95.36, 93.13),
    ChartData(DateTime(2016, 01, 29), 90.97, 101.19, 95.36, 97.13),
    ChartData(DateTime(2016, 02, 03), 98.97, 91.19, 95.36, 87.13),
    ChartData(DateTime(2016, 02, 05), 101.97, 101.19, 92.36, 94.02),
    ChartData(DateTime(2016, 02, 11), 84.97, 91.19, 95.36, 93.13),
    ChartData(DateTime(2016, 02, 19), 90.97, 101.19, 95.36, 97.13),
    ChartData(DateTime(2016, 02, 21), 90.97, 101.19, 95.36, 97.13),
    ChartData(DateTime(2016, 02, 25), 101.97, 101.19, 92.36, 94.02),
    ChartData(DateTime(2016, 02, 27), 84.97, 91.19, 95.36, 93.13),
    ChartData(DateTime(2016, 02, 29), 90.97, 101.19, 95.36, 97.13),
  ];

  @override
  void initState() {
    setState(() {
      forexproviderstodisplay = forexproviders;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Forex Screen"),
          centerTitle: true,
          backgroundColor: Colors.blue[600],
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 450,
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                      HiloOpenCloseSeries<ChartData, dynamic>(
                        dataSource: data,
                        xValueMapper: (ChartData sales, _) => sales.x,
                        highValueMapper: (ChartData sales, _) => sales.high,
                        lowValueMapper: (ChartData sales, _) => sales.low,
                        openValueMapper: (ChartData sales, _) => sales.open,
                        closeValueMapper: (ChartData sales, _) => sales.close,
                      )
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
            Expanded(
              child: SizedBox(
                height: 300,
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
