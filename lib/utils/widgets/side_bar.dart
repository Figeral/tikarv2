import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/mediaquery_manager.dart';

class SideBar extends StatefulWidget {
  final void Function(int currentIndex) onSelected;
  const SideBar({super.key, required this.onSelected});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int selectedIndex = 0;
  int? hoveredIndex;

  MenuData data = MenuData();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: context.height * 0.15, horizontal: 25),
      color: AppColors.white,
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(data, index),
      ),
    );
  }

  Widget buildMenuEntry(MenuData data, int index) {
    final isSelected = selectedIndex == index;
    final isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border:
              isSelected ? Border.all(width: 2, color: AppColors.black) : null,
          color: isHovered && !isSelected
              ? AppColors.grey.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: InkWell(
          onTap: () => setState(() {
            selectedIndex = index;
            widget.onSelected(selectedIndex);
          }),
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                child: Icon(
                  data.menu[index].icon,
                  color: isSelected || isHovered ? AppColors.blue : Colors.grey,
                ),
              ),
              Text(
                data.menu[index].title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected || isHovered ? AppColors.blue : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuData {
  List<IconModel> menu = const <IconModel>[
    IconModel(icon: Icons.home, title: AppStrings.real_estate),
    IconModel(icon: Icons.key, title: AppStrings.rent),
    IconModel(icon: Icons.people_alt, title: AppStrings.tenant),
    IconModel(icon: Icons.person, title: AppStrings.lessor),
    IconModel(icon: Icons.engineering, title: AppStrings.staff),
  ];
}

class IconModel {
  final IconData icon;
  final String title;
  const IconModel({required this.icon, required this.title});
}
