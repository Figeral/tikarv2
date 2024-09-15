import 'package:flutter/material.dart';

class SnackBarMessenger {
  static stateSnackMessenger(
      {required BuildContext context,
      required String message,
      String? action,
      required String type}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type == "error" ? Colors.red : Colors.greenAccent,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        action: SnackBarAction(
          label: action ?? "cancel",
          onPressed: () {},
        ),
      ),
    );
  }
}
