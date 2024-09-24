import 'package:flutter/material.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/cubits/user_cubit.dart';
import 'package:tikar/cubits/screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/views/desktop/auth/auth.dart';
import 'package:tikar/utils/widgets/App_loader.dart';
import 'package:tikar/utils/local_cache_manager.dart';
import 'package:tikar/views/desktop/boarding_desktop.dart';
import 'package:tikar/views/desktop/tikar/main_screen.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  @override
  void initState() {
    // TODO: Do a custom Loading animation Page
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenCubit, BaseState>(builder: (context, state) {
      return switch (state) {
        Initial() => Builder(builder: (context) {
            context.read<ScreenCubit>().boardingScreen;
            return AppLoader.defaultLoader();
          }),
        Loading() => AppLoader.defaultLoader(),
        Success() => nextScreen(state.data),
        NotFound() => const DesktopBoarding(),
        _ => Container(),
      };
    });
  }

  Widget nextScreen(bool status) {
    return BlocBuilder<ScreenCubit, BaseState>(builder: (context, state) {
      return switch (state) {
        Initial() => Builder(builder: (context) {
            context.read<ScreenCubit>().authScreen;
            return AppLoader.defaultLoader();
          }),
        Loading() => AppLoader.defaultLoader(),
        Success() => const MainScreen(),
        NotFound() => const Auth(),
        _ => Container(),
      };
    });
  }
}
