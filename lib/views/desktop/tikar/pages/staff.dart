import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';

class Staff extends StatelessWidget {
  const Staff({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.staff),
      ),
      body: Center(
        child: Text(AppStrings.staff),
      ),
    );
  }
}
