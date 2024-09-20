import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tikar/cubits/renter_cubit.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:tikar/utils/form/staff_form.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/form/renter_form.dart';
import 'package:tikar/utils/widgets/App_loader.dart';
import 'package:tikar/utils/tables/renter_table.dart';
import 'package:tikar/views/desktop/tikar/main_screen.dart';
import 'package:tikar/utils/widgets/custom_cart_header.dart';

class Tenant extends StatefulWidget {
  const Tenant({super.key});

  @override
  State<Tenant> createState() => _TenantState();
}

class _TenantState extends State<Tenant> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  // late List<RenterModel> renters

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
    // final _cubit = context.cubit<RenterCubit>();
    // _cubit.fetch();
    return BlocConsumer<RenterCubit, BaseState<List<RenterModel?>?>>(
      listener: (context, state) {
        // performs a  fetch on loading state   a
        if (state is Valid) {
          context.read<RenterCubit>().fetch();
        }
      },
      listenWhen: (previous, current) {
        return current is Loading ||
            current is Initial ||
            current is Error ||
            current is Valid;
      },
      builder: (BuildContext context, state) {
        bool _isLoading = state is Loading || state is Initial;
        return Skeletonizer(
          enabled: _isLoading,
          child: switch (state) {
            Initial() || Loading() => Builder(builder: (_) {
                context.read<RenterCubit>().getData();
                return AppLoader.adaptative();
              }),
            Success() => body(context, state.data),
            NotFound() => AppLoader.customLoader("Nothing found , downloading"),
            _ => Container(),
          },
        );
      },
    );
  }

  Widget body(BuildContext context, List<RenterModel?>? _cubit) {
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
                          child: RenterPaginatedSortableTable(
                            data: _cubit,
                            onTap: (RenterModel model) {
                              print(model);
                            },
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
            'Staff',
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
                    onPressed: () {}, icon: const Icon(Icons.settings)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: IconButton(
                    onPressed: context.read<RenterCubit>().fetch,
                    icon: const Icon(Icons.replay)),
              )
            ],
          )
        ],
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
