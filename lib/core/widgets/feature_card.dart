import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/const/colors.dart';
import 'package:notes/core/widgets/text.dart';

class FeatureCard extends StatelessWidget {
  final Map<String, dynamic> feature;
  final double width;
  final ColorScheme colorScheme;

  const FeatureCard({
    super.key,
    required this.feature,
    required this.width,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPremium = feature['isPremium'] as bool;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: width * 0.02,
          ),
          padding: EdgeInsets.all(width * 0.06),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: colorScheme.secondary.withAlpha(20),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withAlpha(10),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  feature['image'],
                  width: width * 0.4,
                  height: width * 0.4,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: width * 0.06),
              TextWidget(
                width: width,
                text: feature['title'].toString().tr(),
                fontSize: width * 0.06,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                textColor: colorScheme.secondary,
                maxLines: 2,
              ),
              SizedBox(height: width * 0.04),
              TextWidget(
                width: width,
                text: feature['desc'].toString().tr(),
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                textColor: colorScheme.inversePrimary.withAlpha(180),
                maxLines: 4,
              ),
            ],
          ),
        ),
        if (isPremium)
          Positioned(
            top: width * 0.05,
            left: width * 0.05,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: width * 0.015,
              ),
              decoration: BoxDecoration(
                // Using custom terracotta color as requested
                color: const Color(0xFFE07A5F),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ColorClass.black.withAlpha(20),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextWidget(
                width: width,
                text: "premium".tr(),
                fontSize: width * 0.03,
                fontWeight: FontWeight.w700,
                textColor: ColorClass.white,
              ),
            ),
          ),
      ],
    );
  }
}
