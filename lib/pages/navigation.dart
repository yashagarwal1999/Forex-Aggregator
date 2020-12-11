import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:forexaggregator/pages/constants.dart';
import 'dart:html' as html;
import 'package:flutter/rendering.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BootstrapContainer(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
        fluid: true,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        // padding: EdgeInsets.all(20.0),
        children: [
          Center(
            child: BootstrapCol(
              sizes: 'col-lg-12',
              child: BootstrapRow(height: 60, children: [
                BootstrapCol(
                    sizes: 'col-lg-4',
                    child: Row(
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            child: Image(
                              fit: BoxFit.fill,
                              //  color: Colors.transparent,
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/hackathon-de50d.appspot.com/o/logo-removebg-preview.png?alt=media&token=01f1275b-f14d-4456-ade1-94de28f90015"),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/about');
                          },
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Forex Aggregator",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                BootstrapCol(
                    sizes: 'col-lg-8',
                    child: BootstrapRow(
                      height: 60,
                      children: [
                        BootstrapCol(
                            sizes: 'col-lg-2',
                            child: InkWell(
                              child: Text(
                                "Homepage",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },
                            )),
                        BootstrapCol(
                            sizes: 'col-lg-2',
                            child: InkWell(
                              child: Text(
                                "About Us",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/about');
                              },
                            )),
                        BootstrapCol(
                            sizes: 'col-lg-2',
                            child: InkWell(
                              child: Text(
                                "Support",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                html.window.open(
                                    "https://zealous-spence-77ab2f.netlify.app/",
                                    'new-tab');
                              },
                            )),
                        BootstrapCol(
                            sizes: 'col-lg-6',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.account_circle,
                                    // style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: 15,
                                    //     fontWeight: FontWeight.bold),
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/profile');
                                  },
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                OutlineButton(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                      width: 3),
                                  color: Colors.transparent,
                                  child: Text("Sign Out",
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    Navigator.popAndPushNamed(
                                        context, '/signout');
                                  },
                                )
                              ],
                            )),
                      ],
                    ))
              ]),
            ),
          )
        ]);
  }
}
