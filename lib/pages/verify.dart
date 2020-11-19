import 'package:flutter/material.dart';
import 'package:forexaggregator/pages/constants.dart';

class Verify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Please verify your email address to get started...",
          ),
          Text(
            "Click continue after verification!",
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white),
            ),
            color: kPrimaryColor,
          )
        ]);
  }
}
