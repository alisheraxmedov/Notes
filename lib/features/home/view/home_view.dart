import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:notes/core/const/item_colors.dart';
import 'package:notes/core/utils/date_formatter.dart';
import 'package:notes/core/widgets/notes_card.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/note/controller/note_controller.dart';
import 'package:notes/features/note/view/add_note_view.dart';
import 'package:notes/features/settings/view/settings_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteController noteController = Get.find();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
//===============================================================================
//=================================== HEADER ====================================
//===============================================================================
                Padding(
                  padding: EdgeInsets.only(
                    top: width * 0.04,
                    bottom: width * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // App Title
                      TextWidget(
                        width: width,
                        text: "app_title".tr(),
                        fontSize: width * 0.075,
                        fontWeight: FontWeight.w700,
                        textColor: colorScheme.secondary,
                      ),
                      // Settings Button
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            const SettingScreen(),
                            transition: Transition.cupertino,
                            arguments: ['', '', ''],
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(width * 0.03),
                          decoration: BoxDecoration(
                            color: colorScheme.secondary.withAlpha(15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.settings_outlined,
                            size: width * 0.06,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
//===============================================================================
//================================= SEARCH BAR ==================================
//===============================================================================
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.secondary.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (val) {
                      noteController.searchQuery.value = val;
                    },
                    cursorColor: colorScheme.secondary,
                    decoration: InputDecoration(
                      hintText: "search".tr(),
                      hintStyle: TextStyle(
                        color: colorScheme.inversePrimary.withAlpha(100),
                        fontFamily: "Courier",
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.04, right: width * 0.02),
                        child: Icon(
                          Icons.search_rounded,
                          color: colorScheme.secondary.withAlpha(150),
                          size: width * 0.06,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: width * 0.12,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: width * 0.04,
                      ),
                    ),
                    style: TextStyle(
                      color: colorScheme.inversePrimary,
                      fontFamily: "Courier",
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.04),
//===============================================================================
//================================= NOTES LIST ==================================
//===============================================================================
                if (noteController.filteredNotesList.isEmpty)
                  Expanded(
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
                              noteController.allNotesList.isEmpty
                                  ? Icons.note_add_outlined
                                  : Icons.search_off_rounded,
                              size: width * 0.15,
                              color: colorScheme.secondary.withAlpha(100),
                            ),
                          ),
                          SizedBox(height: width * 0.06),
                          TextWidget(
                            width: width,
                            text: noteController.allNotesList.isEmpty
                                ? "no_notes".tr()
                                : "search_no_results".tr(),
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            textColor: colorScheme.secondary,
                          ),
                          SizedBox(height: width * 0.02),
                          TextWidget(
                            width: width,
                            text: noteController.allNotesList.isEmpty
                                ? "no_notes_hint".tr()
                                : "search_no_results_hint".tr(),
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                            textColor:
                                colorScheme.inversePrimary.withAlpha(120),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: noteController.filteredNotesList.length,
                      itemBuilder: (context, index) {
                        final reversedIndex =
                            noteController.filteredNotesList.length - 1 - index;
                        final note =
                            noteController.filteredNotesList[reversedIndex];
                        final realIndex =
                            noteController.allNotesList.indexOf(note);

                        return NoteCard(
                          id: note.id,
                          index: realIndex,
                          width: width,
                          title: note.title,
                          content: note.content,
                          editedDate:
                              "${"edited".tr()}: ${DateFormatter.formatDate(note.date)} ${note.time}",
                          color: ItemsColor.getColors(context)[reversedIndex %
                              ItemsColor.getColors(context).length],
                          reTime: note.nDate == "Date" || note.nDate == null
                              ? "${"reminder_time".tr()}: ${"not_specified".tr()}"
                              : "${"reminder_time".tr()}: ${DateFormatter.formatDate(note.nDate)} ${note.nTime}",
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withAlpha(60),
              blurRadius: 16,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
          ],
        ),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          elevation: 0,
          onPressed: () {
            Get.to(
              const AddNoteScreen(),
              transition: Transition.cupertino,
              arguments: ['', '', ''],
            )?.then((value) {});
            noteController.initialDateTime();
          },
          child: Icon(
            Icons.add_rounded,
            size: width * 0.08,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
