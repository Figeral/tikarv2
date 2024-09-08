import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/utils/mediaquery_manager.dart';

class CustomCartHeader extends StatefulWidget {
  final int selectedIndex;
  final Function(int index) onSelected;

  const CustomCartHeader({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  State<CustomCartHeader> createState() => _CustomCartHeaderState();
}

class _CustomCartHeaderState extends State<CustomCartHeader> {
  int? _hoveredIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
          width: context.width * 0.6,
          height: context.height * 0.32,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(CardUtile(
                        name: AppStrings.lessors_state[0],
                        value: 0,
                        icon: Icons.manage_accounts_outlined)),
                    _buildNavItem(CardUtile(
                        name: AppStrings.lessors_state[1],
                        value: 1,
                        icon: Icons.man)),
                    _buildNavItem(CardUtile(
                      name: AppStrings.lessors_state[2],
                      value: 2,
                      otherIcon: "assets/images/cameroon.svg",
                    )),
                    _buildNavItem(CardUtile(
                        name: AppStrings.lessors_state[3],
                        value: 3,
                        icon: Icons.rocket_launch_outlined)),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _buildNavItem(CardUtile card) {
    final isSelected = widget.selectedIndex == card.value;
    final isHovered = _hoveredIndex == card.value;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = card.value),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: () => widget.onSelected(card.value),
        child: AnimatedContainer(
          constraints: BoxConstraints(minHeight: 100, minWidth: 100),
          height: 120,
          width: 150,
          duration: Duration(milliseconds: 00),
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: isHovered && !isSelected
                  ? Colors.grey[200]
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: isSelected ? Border.all(width: 2) : null),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                card.icon != null
                    ? Icon(
                        size: 35,
                        card.icon,
                        color: isSelected ? AppColors.blue : AppColors.grey,
                      )
                    : SvgPicture.asset(
                        height: 35,
                        card.otherIcon!,
                        color: isSelected ? AppColors.blue : AppColors.grey,
                      ),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  card.name,
                  style: TextStyle(
                    color: isSelected ? AppColors.blue : AppColors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
