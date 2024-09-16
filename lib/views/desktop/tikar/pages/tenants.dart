import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:tikar/viewmodels/renter_vm.dart';
import 'package:tikar/utils/mediaquery_manager.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Tenant extends StatefulWidget {
  const Tenant({super.key});

  @override
  State<Tenant> createState() => _TenantState();
}

class _TenantState extends State<Tenant> {
  final renter = RenterVM();
  late List<RenterModel> renters;
  void initialize() async {
    renters = await renter.getData();
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
                    name: AppStrings.tenants_state[0],
                    value: 0,
                    otherIcon: "assets/images/tenant.svg"),
                CardUtile(
                    name: AppStrings.tenants_state[1],
                    value: 1,
                    otherIcon: "assets/images/total-tenant.svg"),
                CardUtile(
                  name: AppStrings.tenants_state[2],
                  value: 2,
                  otherIcon: "assets/images/person.svg",
                ),
                CardUtile(
                    name: AppStrings.tenants_state[3],
                    value: 3,
                    otherIcon: "assets/images/enterprise.svg")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
