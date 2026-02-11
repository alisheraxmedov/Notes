import 'package:flutter/material.dart';

/// A single item in the custom bottom navigation bar.
/// Displays an icon with an animated active-state background.
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width * 0.12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(width * 0.025),
              decoration: BoxDecoration(
                color: isActive
                    ? colorScheme.secondary.withAlpha(20)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                isActive ? activeIcon : icon,
                size: width * 0.06,
                color: isActive
                    ? colorScheme.secondary
                    : colorScheme.inversePrimary.withAlpha(120),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
