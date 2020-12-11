import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'navigation.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  "https://www.teahub.io/photos/full/153-1536778_1920x1080-1440x9001280x800-navy-blue-gradient-background.jpg")),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BootstrapRow(height: 100, children: [
            BootstrapCol(sizes: 'col-12', child: Navigation()),
            BootstrapCol(
                sizes: 'col-sm-12 col-md-3 col-lg-3',
                child: Card(
                  child: Column(
                    children: [
                      Image(
                        height: 400,
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/hackathon-de50d.appspot.com/o/0.jpeg?alt=media&token=b29ff695-d839-4ce1-9f16-ebd98802cc40"),
                      ),
                      Text(
                        "Onkar Bendre",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Full Stack Developer",
                        style: TextStyle(fontSize: 20),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          // FlatButton.icon(
                          //   onPressed: null,
                          //   icon: Icon(Icons.),

                          // )
                        ],
                      )
                    ],
                  ),
                )),
            BootstrapCol(
                sizes: 'col-sm-12 col-md-3 col-lg-3',
                child: Card(
                  child: Column(
                    children: [
                      Image(
                          height: 400,
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/hackathon-de50d.appspot.com/o/WhatsApp%20Image%202020-11-28%20at%2012.31.20%20AM.jpeg?alt=media&token=eb387fda-d0cd-4743-9af1-9594d20e83e5")),
                      Text(
                        "Sanket Gattani",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Full Stack Developer",
                        style: TextStyle(fontSize: 20),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          // FlatButton.icon(
                          //   onPressed: null,
                          //   icon: Icon(Icons.),

                          // )
                        ],
                      )
                    ],
                  ),
                )),
            BootstrapCol(
                sizes: 'col-sm-12 col-md-3 col-lg-3',
                child: Card(
                  child: Column(
                    children: [
                      Image(
                        height: 400,
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/hackathon-de50d.appspot.com/o/WhatsApp%20Image%202020-11-28%20at%2012.31.46%20AM.jpeg?alt=media&token=711b930d-eba7-4fae-9867-62f7352df62f"),
                      ),
                      Text(
                        "Yash Agarwal",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Full Stack Developer",
                        style: TextStyle(fontSize: 20),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          // FlatButton.icon(
                          //   onPressed: null,
                          //   icon: Icon(Icons.),

                          // )
                        ],
                      )
                    ],
                  ),
                )),
            BootstrapCol(
                sizes: 'col-sm-12 col-md-3 col-lg-3',
                child: Card(
                  child: Column(
                    children: [
                      Image(
                          height: 400,
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/hackathon-de50d.appspot.com/o/WhatsApp%20Image%202020-11-28%20at%2012.32.36%20AM.jpeg?alt=media&token=56b758bf-7d03-432b-871d-dbfd491e3eb6")),
                      Text(
                        "Rushikesh Tapadiya",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Machine Learning Developer",
                        style: TextStyle(fontSize: 20),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          // FlatButton.icon(
                          //   onPressed: null,
                          //   icon: Icon(Icons.),

                          // )
                        ],
                      )
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
