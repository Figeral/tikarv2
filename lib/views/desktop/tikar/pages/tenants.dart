import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/cubits/renter_cubit.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:tikar/utils/form/staff_form.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/form/renter_form.dart';
import 'package:tikar/utils/tables/renter_table.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Tenant extends StatefulWidget {
  const Tenant({super.key});

  @override
  State<Tenant> createState() => _TenantState();
}

class _TenantState extends State<Tenant> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  // late List<RenterModel> renters;

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
    final _cubit = context.cubit<RenterCubit>();
    _cubit.fetch();
    return Scaffold(
      floatingActionButton: defaultAnimatedFAB(),
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
                                Container(
                                    width: context.width * 0.6,
                                    height: context.width * 0.6,
                                    child: RenterPaginatedSortableTable(
                                        data: _cubit.renter!))
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                  )
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
    );
  }

  CustomCartHeader cardHeader(List<RenterModel?> data) {
    return CustomCartHeader(
      data: [
        data.where((e) => e!.isActive == true).toList().length,
        data.length,
        data
            .where((e) => e!.gender.contains("Personne") == true)
            .toList()
            .length,
        data
            .where((e) => e!.gender.contains("Entreprise") == true)
            .toList()
            .length,
      ],
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
                        child: RenterForm(
                          height: 400 * _controller.value,
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
