import 'package:flutter/material.dart';
import 'package:tikar/views/phone/home_phone.dart';
import 'package:tikar/views/desktop/home_desktop.dart';

Future<void> main(List<String> args) async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
          builder: ((context, constraints) => constraints.maxWidth > 450
              ? const DesktopHome()
              : const PhoneHome())),
      theme: ThemeData(fontFamily: "Poppins"),
    );
  }
}