import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.rent),
      ),
    );
  }
}
