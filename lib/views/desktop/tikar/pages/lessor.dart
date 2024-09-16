import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/viewmodels/lessor_vm.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Lessor extends StatefulWidget {
  const Lessor({super.key});

  @override
  State<Lessor> createState() => _LessorState();
}

class _LessorState extends State<Lessor> {
  final lessor = LessorVM();
  late List<LessorModel> lessors;
  void initialize() async {
    lessors = await lessor.getData();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

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
                    name: AppStrings.lessors_state[0],
                    value: 0,
                    icon: Icons.manage_accounts_outlined),
                CardUtile(
                    name: AppStrings.lessors_state[1],
                    value: 1,
                    icon: Icons.man),
                CardUtile(
                  name: AppStrings.lessors_state[2],
                  value: 2,
                  otherIcon: "assets/images/cameroon.svg",
                ),
                CardUtile(
                    name: AppStrings.lessors_state[3],
                    value: 3,
                    icon: Icons.rocket_launch_outlined)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
