import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';

class Tenant extends StatelessWidget {
  const Tenant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.tenant),
      ),
    );
  }
}
