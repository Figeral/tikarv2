import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tikar/cubits/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/views/phone/home_phone.dart';
import 'package:tikar/views/desktop/home_desktop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart' as window_size;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // final c = await SharedPreferences.getInstance();
  // c.clear();
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    window_size.setWindowMinSize(const Size(1400, 900));
    window_size.setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LayoutBuilder(
            builder: ((context, constraints) => constraints.maxWidth > 450
                ? const DesktopHome()
                : const PhoneHome())),
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
