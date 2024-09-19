import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
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

class _RealEstateState extends State<RealEstate>
    with SingleTickerProviderStateMixin {
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

  bool _isVisible = false;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void toggle() {
    _controller.isDismissed ? _controller.forward() : _controller.reverse();
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: defaultAnimatedFAB(),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCartHeader(
                      data: [
                        1,
                        2,
                        3,
                        4,
                      ],
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
              ),
              Visibility(
                visible: _isVisible,
                child: GestureDetector(
                  onTap: toggle,
                  child: Container(
                    width: context.width,
                    height: context.height + context.height / 2,
                    color: const Color.fromARGB(100, 12, 12, 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedBuilder defaultAnimatedFAB() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final sHeight = MediaQuery.of(context).size.height;
        final sWidth = MediaQuery.of(context).size.width;
        double dividor = 1;
        const miniSize = 70;
        const miniOpacity = 0.5;
        const macroOpacity = 0;
        double dx = 50;
        double dy = 100;
        dividor = _controller.value * 2;

        final size = miniSize + (_controller.value * 30);
        final opacity = miniOpacity + (_controller.value * miniOpacity);
        double mO = _controller.value >= 0.5 ? _controller.value * 1 : 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            dividor != 0
                ? AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: mO,
                    child: Transform.translate(
                        offset: Offset(
                            dx * -_controller.value, dy * -_controller.value),
                        child: child),
                  )
                : Opacity(
                    opacity: 0,
                    child: Container(),
                  ),
            SizedBox(
              width: size,
              height: size,
              child: FittedBox(
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 100),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.golden,
                    tooltip: "add staff",
                    onPressed: toggle,
                    child: dividor != 0
                        ? Transform.rotate(
                            angle: (math.pi / 2) / dividor,
                            child: Icon(
                              Icons.add,
                              size: size / 2,
                            ),
                          )
                        : Icon(
                            Icons.add,
                            size: size / 2,
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
