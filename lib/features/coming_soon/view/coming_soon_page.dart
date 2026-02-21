import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/widgets/text.dart';

import 'package:notes/core/widgets/feature_card.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _features = [
    {
      "title": "ai_voice_title",
      "desc": "ai_voice_desc",
      "image": "assets/images/ai_voice.png",
      "isPremium": true,
    },
    {
      "title": "multi_device_title",
      "desc": "multi_device_desc",
      "image": "assets/images/multi_device.png",
      "isPremium": true,
    },
    {
      "title": "share_notes_title",
      "desc": "share_notes_desc",
      "image": "assets/images/share_notes.png",
      "isPremium": false,
    },
    {
      "title": "ai_summary_title",
      "desc": "ai_summary_desc",
      "image": "assets/images/ai_summary.png",
      "isPremium": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceDim,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          width: width,
          text: "coming_soon".tr(),
          fontSize: width * 0.075,
          fontWeight: FontWeight.w700,
          textColor: colorScheme.secondary,
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: width * 0.05),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _features.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                      } else {
                        value = index == _currentPage ? 1.0 : 0.8;
                      }

                      return Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) *
                              (MediaQuery.sizeOf(context).height * 0.6),
                          width:
                              Curves.easeOut.transform(value) * (width * 0.8),
                          child: child,
                        ),
                      );
                    },
                    child: FeatureCard(
                      feature: _features[index],
                      width: width,
                      colorScheme: colorScheme,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: width * 0.05),
            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _features.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  height: width * 0.02,
                  width: _currentPage == index ? width * 0.06 : width * 0.02,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? colorScheme.secondary
                        : colorScheme.secondary.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: width * 0.1),
          ],
        ),
      ),
    );
  }
}
