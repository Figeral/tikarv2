import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';

class AppLoader {
  static Widget defaultLoader() => const Scaffold(
        body: Center(
          child: SizedBox(
            height: 100,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Loading",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  width: 5,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
}
