import 'dart:math';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/cubits/asset_cubit.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/form/asset_form.dart';
import 'package:tikar/utils/tables/asset_table.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class RealEstate extends StatefulWidget {
  const RealEstate({super.key});

  @override
  State<RealEstate> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstate> with TickerProviderStateMixin {
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
    return BlocConsumer<AssetCubit, BaseState<List<AssetModel?>?>>(
      listener: (context, state) {
        if (state is Valid) {
          context.read<AssetCubit>().fetch();
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
              context.read<AssetCubit>().getData();
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

  Widget body(BuildContext context, List<AssetModel?>? _cubit) {
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
                        SizedBox(
                          width: context.width * 0.6,
                          child: AssetPaginatedSortableTable(
                            data: _cubit,
                          ),
                        )
                      ],
                    ),
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
            'Real Estate',
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
                    onPressed: context.read<AssetCubit>().fetch,
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

  CustomCartHeader cardHeader(List<AssetModel?> data) {
    return CustomCartHeader(
      data: [
        data.where((e) => e!.isActive == true).toList().length,
        data.length,
        data.where((e) => e!.assetType!.contains("Residence")).toList().length,
        data.where((e) => e!.assetType!.contains("Building")).toList().length,
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
                        child: AssetForm(
                          height: 800 * _controller.value,
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
                    tooltip: "add asset",
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
