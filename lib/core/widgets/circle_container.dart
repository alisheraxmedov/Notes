import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final double width;
  final IconData icon;
  final Color color;
  final void Function()? onPressed;
  const CircleContainer({
    super.key,
    required this.icon,
    required this.width,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.12,
      width: width * 0.12,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
