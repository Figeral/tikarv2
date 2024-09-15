import 'package:flutter/material.dart';
import 'package:tikar/views/desktop/auth/auth.dart';
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
    return FutureBuilder(
        future: LocalCacheManager.getFlag(name: "onboarding_finished"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ///Implement a Future builder case for if the user is already login or  not
            ///so at the place of const Auth() it will be something like
            ///LocalCahemanager.getFlag("already_auth")==true?MainScreen :Auth()
            return FutureBuilder(
                future: LocalCacheManager.getToken("user_token"),
                builder: (_, snapshot) {
                  return snapshot.hasData ? const MainScreen() : const Auth();
                });
          }
          return const DesktopBoarding();
        });
  }
}
