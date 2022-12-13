import 'package:flutter/material.dart';
//import 'package:web_example/resource/string_resources.dart';

class ColorsResources {
  static const logoColor = Color(0xFF54C5F8);
  static const primaryColor = Color(0xFF0075FF);
  static const primaryTextColor = Color(0xFF464646);
}

class StringResource {
  static const String logoName = "WEB EXAMPLE";
  static const String header = "Create A Flutter Web Application";
  static const String paragraph =
      "Membuat webiste landing page sederhana menggunakan Flutter";
  static const String homeMenu = "Home";
  static const String aboutUsMenu = "About Us";
  static const String signup = "Sign Up";
  static const String signin = "Sign In";
  static const String getStarted = "Get Started";
}

class Navbar {
  static isMobile() {
    return AppBar(
      actionsIconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: const Text(
        StringResource.logoName,
        style: TextStyle(
            color: ColorsResources.logoColor, fontWeight: FontWeight.w800),
      ),
    );
  }

  static isDesktop() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: const Text(
        StringResource.logoName,
        style: TextStyle(
            color: ColorsResources.logoColor, fontWeight: FontWeight.w800),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Row(
            children: [
              TextButton(
                child: const Text(StringResource.homeMenu),
                onPressed: () {},
              ),
              TextButton(
                child: const Text(StringResource.aboutUsMenu),
                onPressed: () {},
              ),
              const SizedBox(width: 24),
              TextButton(
                child: const Text(StringResource.signin),
                onPressed: () {},
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          color: ColorsResources.primaryColor)),
                  foregroundColor: ColorsResources.primaryColor,
                ),
                child: const Text(StringResource.signup),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
