import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static Future push(BuildContext context, {required Widget destination}) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => destination));
}
