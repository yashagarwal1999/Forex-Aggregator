import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'constants.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  image: NetworkImage(
                      "https://www.waehrungshandel.de/wp/wp-content/uploads/boersenindikatoren.jpg"),
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: [
                      BootstrapCol(
                        sizes: 'col-lg-12 ',
                        child: BootstrapRow(
                          height: 30,
                          children: [
                            BootstrapCol(
                              sizes: 'col-lg-10 col-sm-10 col-md-10',
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
                              ),
                            ),
                            BootstrapCol(
                                sizes: 'col-lg-2 col-sm-2 col-md-2',
                                child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 3),
                                  color: Colors.transparent,
                                  child: Text("LogIn",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                )),
                          ],
                        ),
                      ),
                      Center(
                        child: BootstrapCol(
                          sizes: 'col-6',
                          child: Container(
                            height: MediaQuery.of(context).size.height - 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Forex Aggregator",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 45),
                                ButtonTheme(
                                  height: 50,
                                  minWidth: 70,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    child: Text("Get Started!"),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/');
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
