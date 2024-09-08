import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/utils/mediaquery_manager.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Rent extends StatefulWidget {
  const Rent({super.key});

  @override
  State<Rent> createState() => _RentState();
}

class _RentState extends State<Rent> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: SingleChildScrollView(
        child: Column(
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
                  name: AppStrings.rents_state[0],
                  value: 0,
                  otherIcon: "assets/images/actual-rents.svg",
                ),
                CardUtile(
                  name: AppStrings.rents_state[1],
                  value: 1,
                  otherIcon: "assets/images/total-rents.svg",
                ),
                CardUtile(
                  name: AppStrings.rents_state[2],
                  value: 2,
                  otherIcon: "assets/images/appartement.svg",
                ),
                CardUtile(
                  name: AppStrings.rents_state[3],
                  value: 3,
                  otherIcon: "assets/images/residence-building.svg",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
