import 'package:flutter/material.dart';
import 'package:tikar/utils/widgets/side_bar.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SideBar(
              onSelected: (int currentIndex) {},
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(flex: 10, child: Container()),
        ],
      ),
    );
  }
}
