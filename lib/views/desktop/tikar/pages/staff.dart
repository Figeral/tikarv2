import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/cubits/staff_cubit.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/staff_vm.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Staff extends StatefulWidget {
  const Staff({super.key});

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<StaffCubit>(context);
    cubit.fetch();
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
                    name: AppStrings.employees_state[0],
                    value: 0,
                    otherIcon: "assets/images/staff.svg"),
                CardUtile(
                    name: AppStrings.employees_state[1],
                    value: 1,
                    otherIcon: "assets/images/employee.svg"),
                CardUtile(
                  name: AppStrings.employees_state[2],
                  value: 2,
                  otherIcon: "assets/images/interne.svg",
                ),
                CardUtile(
                    name: AppStrings.employees_state[3],
                    value: 3,
                    otherIcon: "assets/images/externe.svg")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
