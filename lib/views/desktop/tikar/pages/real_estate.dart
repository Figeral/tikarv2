import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';
import 'package:tikar/utils/widgets/paginated_data_table.dart';

class RealEstate extends StatefulWidget {
  const RealEstate({super.key});

  @override
  State<RealEstate> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstate> {
  List<DataItem> generateTestData() {
    final random = Random();
    final names = [
      'John',
      'Alice',
      'Bob',
      'Emma',
      'Michael',
      'Olivia',
      'William',
      'Sophia',
      'James',
      'Isabella',
      'Benjamin',
      'Mia',
      'Jacob',
      'Charlotte',
      'Ethan',
      'Amelia',
      'Daniel',
      'Harper',
      'Matthew',
      'Evelyn',
      'Joseph',
      'Abigail',
      'David',
      'Emily',
      'Alexander',
      'Elizabeth',
      'Henry'
    ];

    return List.generate(27, (index) {
      return DataItem(
        name: names[index],
        number: random.nextInt(100) + 1,
        isActive: random.nextBool(),
        date: DateTime(2023, random.nextInt(12) + 1, random.nextInt(28) + 1),
      );
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  otherIcon: "assets/images/building.svg"),
            ],
          ),
          SizedBox(
            width: context.width * 0.6,
            // height: context.height * 0.32,
            child: PaginatedSortableTable(data: generateTestData()),
          ),
        ],
      ),
    );
  }
}
