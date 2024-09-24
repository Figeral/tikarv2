import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';

class SnackBarMessenger {
  static stateSnackMessenger(
      {required BuildContext context,
      required String message,
      String? action,
      String? type}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: switch (type) {
          "error" => Colors.redAccent,
          "success" => Colors.greenAccent,
          _ => Colors.grey,
        },
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
