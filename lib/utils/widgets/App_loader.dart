import 'package:flutter/material.dart';

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
  static Widget customLoader(String message) => Scaffold(
        body: Center(
          child: SizedBox(
            height: 100,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  width: 5,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
  static Widget adaptative() => const CircularProgressIndicator.adaptive();
}
