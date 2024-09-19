import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/icons_utile.dart';
import 'package:tikar/extensions/extensions.dart';

class CustomCartHeader extends StatefulWidget {
  final List<CardUtile> cardUtile;
  final List<int> data;
  final int selectedIndex;
  final Function(int index) onSelected;

  const CustomCartHeader({
    super.key,
    required this.cardUtile,
    required this.data,
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
      child: Container(
          width: context.width * 0.6,
          //height: context.height * 0.32,
          constraints: const BoxConstraints(maxHeight: 320),
          child: Card(
            color: AppColors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 20),
                    width: 350,
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: context.width * 0.05,
                        ),
                        Text(
                          "${widget.data[widget.selectedIndex]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: AppColors.blue),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            "effectifs",
                            style: TextStyle(color: AppColors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(widget.cardUtile[0]),
                      _buildNavItem(widget.cardUtile[1]),
                      _buildNavItem(widget.cardUtile[2]),
                      _buildNavItem(widget.cardUtile[3]),
                    ],
                  )
                ],
              ),
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
          constraints: const BoxConstraints(minHeight: 100, minWidth: 100),
          height: 120,
          width: 150,
          duration: const Duration(milliseconds: 00),
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
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
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
