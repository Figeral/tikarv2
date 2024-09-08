import 'package:flutter/material.dart';
import 'package:tikar/utils/widgets/side_bar.dart';
import 'package:tikar/views/desktop/tikar/pages/rent.dart';
import 'package:tikar/views/desktop/tikar/pages/staff.dart';
import 'package:tikar/views/desktop/tikar/pages/lessor.dart';
import 'package:tikar/views/desktop/tikar/pages/tenants.dart';
import 'package:tikar/views/desktop/tikar/pages/real_estate.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[RealEstate(), Rent(), Tenant(), Lessor(), Staff()];

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SideBar(
              onSelected: (int currentIndex) {
                setState(() {
                  _pageIndex = currentIndex;
                });
              },
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(flex: 10, child: pages[_pageIndex]),
        ],
      ),
    );
  }
}
