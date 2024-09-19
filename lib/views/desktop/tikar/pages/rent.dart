import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Rent extends StatefulWidget {
  const Rent({super.key});

  @override
  State<Rent> createState() => _RentState();
}

class _RentState extends State<Rent> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
  }

  void toggle() {
    _controller.isDismissed ? _controller.forward() : _controller.reverse();
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
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
          child: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    cartHeader(),
                  ],
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
      ),
    );
  }

  CustomCartHeader cartHeader() {
    return CustomCartHeader(
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
