import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      getInit();
    });
    super.initState();
  }

  getInit() {
    final storage = GetStorage();

    final token = storage.read("token");
    final area = storage.read("area");

    if (area == null) {
      Navigator.popAndPushNamed(context, "/config");
    } else {
      if (token != "" && token != null) {
        Navigator.popAndPushNamed(context, "/home");
      } else {
        Navigator.popAndPushNamed(context, "/login");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/icons/ic_logo_sutindo.png")))),
            ),
          ],
        ))));
  }
}
