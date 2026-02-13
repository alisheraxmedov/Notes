import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/const/nav_pages.dart';
import 'package:notes/core/widgets/bottom_nav_fab.dart';
import 'package:notes/core/widgets/bottom_nav_item.dart';
import 'package:notes/features/home/view/home_view.dart';
import 'package:notes/features/main/controller/main_controller.dart';
import 'package:notes/features/missed_notes/view/missed_notes_view.dart';
import 'package:notes/features/note/controller/note_controller.dart';
import 'package:notes/features/note/view/add_note_view.dart';
import 'package:notes/features/settings/view/settings_view.dart';

/// Main wrapper screen that hosts the bottom navigation bar
/// and switches between [HomeScreen], [MissedNotesScreen], and [SettingScreen].
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());
    final NoteController noteController = Get.find();
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.sizeOf(context).width;

    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            //========== Page Content ==========
            IndexedStack(
              index: controller.activeIndex.value,
              children: NavBarPages.pages,
            ),
//======================================================================
//==================== BOTTOM NAVIGATION BAR ===========================
//======================================================================
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.secondary.withAlpha(20),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: width * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //========== Home Tab ==========
                        BottomNavItem(
                          icon: Icons.home_outlined,
                          activeIcon: Icons.home_rounded,
                          isActive: controller.activeIndex.value == 0,
                          onTap: () => controller.changeTab(0),
                        ),

                        //========== Missed Notes Tab ==========
                        BottomNavItem(
                          icon: Icons.access_time_outlined,
                          activeIcon: Icons.access_time_filled,
                          isActive: controller.activeIndex.value == 1,
                          onTap: () => controller.changeTab(1),
                        ),

                        //========== FAB (Add Note) ==========
                        BottomNavFab(
                          onTap: () {
                            Get.to(
                              const AddNoteScreen(),
                              transition: Transition.cupertino,
                              arguments: ['', '', ''],
                            )?.then((value) {});
                            noteController.initialDateTime();
                          },
                        ),

                        //========== Coming Soon Tab ==========
                        BottomNavItem(
                          icon: Icons.rocket_launch_outlined,
                          activeIcon: Icons.rocket_launch_rounded,
                          isActive: controller.activeIndex.value == 2,
                          onTap: () => controller.changeTab(2),
                        ),

                        //========== Settings Tab ==========
                        BottomNavItem(
                          icon: Icons.settings_outlined,
                          activeIcon: Icons.settings_rounded,
                          isActive: controller.activeIndex.value == 3,
                          onTap: () => controller.changeTab(3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
