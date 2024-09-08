import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';
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
        ),
      ],
    );
  }
}
