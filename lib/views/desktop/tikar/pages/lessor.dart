import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tikar/cubits/lessor_cubit.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/form/lessor_form.dart';
import 'package:tikar/utils/widgets/App_loader.dart';
import 'package:tikar/utils/tables/lessor_table.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Lessor extends StatefulWidget {
  const Lessor({super.key});

  @override
  State<Lessor> createState() => _LessorState();
}

class _LessorState extends State<Lessor> with TickerProviderStateMixin {
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
    return BlocConsumer<LessorCubit, BaseState<List<LessorModel?>?>>(
      listener: (context, state) {
        if (state is Valid) {
          context.read<LessorCubit>().fetch();
        }
      },
      listenWhen: (previous, current) {
        return current is Loading ||
            current is Initial ||
            current is Error ||
            current is Valid;
      },
      builder: (BuildContext context, state) {
        return switch (state) {
          Initial() => Builder(builder: (_) {
              context.read<LessorCubit>().getData();
              return Skeletonizer(enabled: true, child: body(context, []));
            }),
          Loading() => Skeletonizer(enabled: true, child: body(context, [])),
          Success() => body(context, state.data),
          NotFound() => body(context, []),
          _ => Container(),
        };
      },
    );
  }

  Widget body(BuildContext context, List<LessorModel?>? _cubit) {
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
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customAppBar(context),
                      cardHeader(_cubit!),
                      Container(
                          width: context.width * 0.6,
                          height: context.width * 0.6,
                          child: LessorPaginatedSortableTable(
                            data: _cubit,
                            // onTap: (LessorModel model) {
                            //   print(model);
                            // },
                          ))
                    ],
                  ))
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

  SizedBox customAppBar(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
          ),
          const Text(
            'Actifs',
            style: TextStyle(
                color: AppColors.grey,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 3, right: 3),
            child: Text('/'),
          ),
          const Text(
            'Lessor',
            style: TextStyle(
                color: AppColors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/images/settings.svg",
                      width: 30,
                      height: 30,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: IconButton(
                    onPressed: context.read<LessorCubit>().fetch,
                    icon: SvgPicture.asset(
                      "assets/images/reload.svg",
                      width: 30,
                      height: 30,
                    )),
              )
            ],
          )
        ],
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
            otherIcon: "assets/images/tenant.svg"),
        CardUtile(
            name: AppStrings.lessors_state[1],
            value: 1,
            otherIcon: "assets/images/total-tenant.svg"),
        CardUtile(
          name: AppStrings.lessors_state[2],
          value: 2,
          otherIcon: "assets/images/cameroon.svg",
        ),
        CardUtile(
            name: AppStrings.lessors_state[3],
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
                        child: LessorForm(
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
                    tooltip: "add lessor",
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
