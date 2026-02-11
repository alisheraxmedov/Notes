import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/widgets/text.dart';

/// Screen for displaying missed / overdue notes.
class MissedNotesScreen extends StatelessWidget {
  const MissedNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.06),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withAlpha(15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded,
                  size: width * 0.15,
                  color: colorScheme.secondary.withAlpha(100),
                ),
              ),
              SizedBox(height: width * 0.06),
              TextWidget(
                width: width,
                text: "missed_notes".tr(),
                fontSize: width * 0.045,
                fontWeight: FontWeight.w600,
                textColor: colorScheme.secondary,
              ),
              SizedBox(height: width * 0.02),
              TextWidget(
                width: width,
                text: "no_missed_notes".tr(),
                fontSize: width * 0.035,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                textColor: colorScheme.inversePrimary.withAlpha(120),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
