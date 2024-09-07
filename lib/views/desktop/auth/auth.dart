import 'package:flutter/material.dart';
import 'package:tikar/utils/app_navigator.dart';
import 'package:tikar/views/desktop/tikar/main_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            AppNavigator.push(context, destination: const MainScreen());
          },
          label: const Text("pass")),
    );
  }
}
