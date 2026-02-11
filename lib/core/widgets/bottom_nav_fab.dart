import 'package:flutter/material.dart';

/// Floating Action Button widget for the bottom navigation bar.
/// Displays a circular button with an icon and shadow.
class BottomNavFab extends StatelessWidget {
  final VoidCallback onTap;

  const BottomNavFab({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.14,
        height: width * 0.14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: colorScheme.secondary.withAlpha(60),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          Icons.add_rounded,
          color: colorScheme.onSecondary,
          size: width * 0.07,
        ),
      ),
    );
  }
}
