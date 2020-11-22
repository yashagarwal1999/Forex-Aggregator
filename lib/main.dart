import 'package:flutter/material.dart';
import 'package:forexaggregator/pages/constants.dart';
import 'pages/main_login.dart';
import 'pages/profile.dart';
import 'pages/homepage.dart';
import 'pages/verify.dart';
import 'pages/providerscreen.dart';
import 'pages/ProfilePage.dart';

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
      initialRoute: '/',
      routes: {
        '/profile': (context) => Profile(),
        '/': (context) => MainLogin(),
        '/home': (context) => Forex("INR", "USD", 30),
        '/verify': (context) => Verify(),
        '/prof': (context) => ProfilePage()
      },
    );
  }
}
