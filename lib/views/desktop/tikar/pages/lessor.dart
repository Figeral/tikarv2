import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';

class Lessor extends StatelessWidget {
  const Lessor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.lessor),
      ),
    );
  }
}
