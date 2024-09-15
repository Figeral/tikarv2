import 'package:flutter/material.dart';
import 'package:tikar/utils/app_asset.dart';
import 'package:tikar/utils/app_colors.dart';

class CustomNavigationRail extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CustomNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  _CustomNavigationRailState createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Leading widget
          Container(
              padding: const EdgeInsets.all(8), child: Image.asset(AppImage.tikar)),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNavItem(Icons.dashboard, 0),
                _buildNavItem(Icons.wallet, 1),
                _buildNavItem(Icons.monetization_on, 2),
                _buildNavItem(Icons.settings, 3)
              ],
            ),
          ),
          // Trailing widget
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.sentiment_satisfied_alt, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = widget.selectedIndex == index;
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: () => widget.onDestinationSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 00),
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: isHovered && !isSelected
                  ? Colors.grey[200]
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: isSelected ? Border.all(width: 2) : null),
          child: Icon(
            icon,
            color: isSelected ? AppColors.blue : AppColors.grey,
          ),
        ),
      ),
    );
  }
}
