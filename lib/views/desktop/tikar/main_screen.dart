import 'package:flutter/material.dart';
import 'package:tikar/cubits/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/views/desktop/tikar/admin.dart';
import 'package:tikar/views/desktop/tikar/asset.dart';
import 'package:tikar/views/desktop/tikar/finance.dart';
import 'package:tikar/views/desktop/tikar/setting.dart';
import 'package:tikar/utils/widgets/custom_navigation_rail.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pages = const <Widget>[
    AdminPage(),
    AssetPage(),
    FinancePage(),
    SettingPage()
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserCubit>(context);
    return Builder(builder: (context) {
      cubit.userInit();
      // print(cubit.user?.toJson().toString());
      return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomNavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: pages[_selectedIndex])
          ],
        ),
      );
    });
  }
}
