import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class RealEstate extends StatefulWidget {
  const RealEstate({super.key});

  @override
  State<RealEstate> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstate> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCartHeader(
          selectedIndex: _selectedIndex,
          onSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          cardUtile: [
            CardUtile(
                name: AppStrings.assets_state[0],
                value: 0,
                otherIcon: "assets/images/actif-asset.svg"),
            CardUtile(
                name: AppStrings.assets_state[1],
                value: 1,
                otherIcon: "assets/images/total-asset.svg"),
            CardUtile(
              name: AppStrings.assets_state[2],
              value: 2,
              otherIcon: "assets/images/residence.svg",
            ),
            CardUtile(
                name: AppStrings.assets_state[3],
                value: 3,
                otherIcon: "assets/images/building.svg")
          ],
        ),
      ],
    );
  }
}
