import 'package:flutter/material.dart';
import 'package:forexaggregator/pages/About.dart';
import 'package:forexaggregator/pages/constants.dart';
import 'package:forexaggregator/pages/signout.dart';
import 'pages/main_login.dart';
import 'pages/profile.dart';
import 'pages/homepage.dart';
import 'pages/verify.dart';
import 'pages/providerscreen.dart';
import 'pages/ProfilePage.dart';
import 'pages/firstpage.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/land',
      routes: {
        '/profile': (context) => ProfilePage(),
        '/': (context) => MainLogin(),
        '/home': (context) => FirstPage(),
        '/verify': (context) => Verify(),
        '/land': (context) => LandingPage(),
        '/signout': (context) => SignOut(),
        '/about': (context) => AboutPage()
      },
    );
  }
}
