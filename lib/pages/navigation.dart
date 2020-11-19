import 'package:flutter/material.dart';
import 'package:forexaggregator/pages/constants.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
      ),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
              backgroundImage: AssetImage(
                  '/home/daredevil/Hackathon/WUHackathon/forexaggregator/lib/assets/logo.png')),
          InkWell(
            onTap: () {
              print("About Pressed");
            },
            hoverColor: Colors.transparent,
            focusColor: Colors.white,
            child: Text(
              "About",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monospace"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            hoverColor: Colors.transparent,
            focusColor: Colors.white,
            child: Text(
              "Homepage",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monospace"),
            ),
          ),
          InkWell(
            onTap: () {
              print("Contact Pressed");
            },
            hoverColor: Colors.transparent,
            focusColor: Colors.white,
            child: Text(
              "Contact",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monospace"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            hoverColor: Colors.transparent,
            focusColor: Colors.white,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monospace"),
            ),
          ),
          InkWell(
            onTap: () {
              print("Login Pressed");
            },
            hoverColor: Colors.transparent,
            focusColor: Colors.white,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monospace"),
            ),
          ),
          InkWell(
            onTap: () {
              print("Profile Pressed");
              Navigator.pushNamed(context, '/profile');
            },
            hoverColor: Colors.transparent,
            focusColor: Colors.white,
            child: Text(
              "Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monospace"),
            ),
          ),
        ],
      ),
    );
  }
}
