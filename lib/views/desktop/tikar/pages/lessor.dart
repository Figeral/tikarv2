import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/cubits/lessor_cubit.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/viewmodels/lessor_vm.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/form/lessor_form.dart';
import 'package:tikar/utils/tables/lessor_table.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Lessor extends StatefulWidget {
  const Lessor({super.key});

  @override
  State<Lessor> createState() => _LessorState();
}

class _LessorState extends State<Lessor> with SingleTickerProviderStateMixin {
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
    final _cubit = BlocProvider.of<LessorCubit>(context);
    _cubit.fetch();
    return Scaffold(
      floatingActionButton: defaultAnimatedFAB(),
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Actifs',
              style: TextStyle(color: AppColors.grey),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3, right: 3),
              child: Text('/'),
            ),
            Text('Lessor'),
          ],
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      endDrawer: Drawer(
        shape: Border.all(width: 1),
        width: context.width * 0.35,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: AnimatedLessorFAB(
      //   onToggle: toggle,
      // ),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: FutureBuilder(
                          future: _cubit.getData(),
                          builder: (_, snapshot) {
                            if (_cubit.state != null) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  cardHeader(_cubit.state!),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                      width: context.width * 0.6,
                                      height: context.width * 0.6,
                                      child: LessorPaginatedSortableTable(
                                          data: _cubit.lessor!)),
                                ],
                              );
                            }
                            return Container();
                          }))
                ],
              ),
              Visibility(
                visible: _isVisible,
                child: GestureDetector(
                  onTap: toggle,
                  child: Container(
                    width: context.width,
                    height: context.height + context.height / 2,
                    color: const Color.fromARGB(60, 12, 12, 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomCartHeader cardHeader(List<LessorModel?> data) {
    return CustomCartHeader(
      data: [
        data.where((e) => e!.isActive == true).toList().length,
        data.length,
        data.where((e) => e!.inCameroon == true).toList().length,
        data.where((e) => e!.inCameroon == false).toList().length,
      ],
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
        CardUtile(name: AppStrings.lessors_state[1], value: 1, icon: Icons.man),
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
                        child: LessorForm(
                          height: 600 * _controller.value,
                          width: 680 * _controller.value,
                        )),
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
