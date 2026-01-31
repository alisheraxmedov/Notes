import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:notes/core/const/item_colors.dart';
import 'package:notes/core/widgets/circle_container.dart';
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
  void initState() {
    super.initState();
    // Sync search text with controller if needed (bi-directional)
    // currently just one-way from UI to Controller is enough
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Obx(
        () {
          // Use controller's filtered list
          if (noteController.filteredNotesList.isEmpty) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withAlpha(125),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: width * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
//===============================================================================
//=================================== HEADER ====================================
//===============================================================================
                    Padding(
                      padding: EdgeInsets.only(
                        top: width * 0.12,
                        bottom: width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Premium Title with subtle glow effect
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.secondary,
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withAlpha(200),
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ).createShader(bounds),
                            child: TextWidget(
                              width: width,
                              text: "app_title".tr(),
                              fontSize: width * 0.085,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.white,
                            ),
                          ),
                          // Enhanced Settings Button with glow
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withAlpha(80),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: CircleContainer(
                              icon: Icons.settings_outlined,
                              width: width,
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () {
                                Get.to(
                                  const SettingScreen(),
                                  transition: Transition.circularReveal,
                                  arguments: ['', '', ''],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
//===============================================================================
//================================= SEARCH BAR ==================================
//===============================================================================
                    // Premium Search Bar with glassmorphism effect
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withAlpha(60),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) {
                          noteController.searchQuery.value = val;
                        },
                        cursorColor: Theme.of(context).colorScheme.primary,
                        decoration: InputDecoration(
                          hintText: "search".tr(),
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(150),
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
                              color: Theme.of(context).colorScheme.surfaceDim,
                              size: width * 0.065,
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
                          color: Theme.of(context).colorScheme.surfaceDim,
                          fontFamily: "Courier",
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
//===============================================================================
//=============================== EMPTY STATE ===================================
//===============================================================================
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: width * 0.1),
                              // Decorative emoji - different for each case
                              Container(
                                padding: EdgeInsets.all(width * 0.06),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withAlpha(20),
                                  shape: BoxShape.circle,
                                ),
                                child: TextWidget(
                                  width: width,
                                  text: noteController.allNotesList.isEmpty
                                      ? "📝"
                                      : "🔍",
                                  fontSize: width * 0.15,
                                ),
                              ),
                              SizedBox(height: width * 0.06),
                              // Main empty text
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withAlpha(180),
                                  ],
                                ).createShader(bounds),
                                child: TextWidget(
                                  width: width,
                                  text: noteController.allNotesList.isEmpty
                                      ? "no_notes".tr()
                                      : "search_no_results".tr(),
                                  fontSize: width * 0.055,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  textColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: width * 0.03),
                              // Subtitle hint - different for each case
                              TextWidget(
                                width: width,
                                text: noteController.allNotesList.isEmpty
                                    ? "no_notes_hint".tr()
                                    : "search_no_results_hint".tr(),
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                textColor: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withAlpha(150),
                              ),
                              SizedBox(height: width * 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withAlpha(125),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                children: [
//===============================================================================
//=================================== HEADER ====================================
//===============================================================================
                  Padding(
                    padding: EdgeInsets.only(
                      top: width * 0.12,
                      bottom: width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(200),
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ).createShader(bounds),
                          child: TextWidget(
                            width: width,
                            text: "app_title".tr(),
                            fontSize: width * 0.085,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withAlpha(80),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: CircleContainer(
                            icon: Icons.settings_outlined,
                            width: width,
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () {
                              Get.to(
                                const SettingScreen(),
                                transition: Transition.circularReveal,
                                arguments: ['', '', ''],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
//===============================================================================
//================================= SEARCH BAR ==================================
//===============================================================================
                  // Premium Search Bar with glassmorphism effect
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withAlpha(60),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (val) {
                        noteController.searchQuery.value = val;
                      },
                      cursorColor: Theme.of(context).colorScheme.primary,
                      decoration: InputDecoration(
                        hintText: "search".tr(),
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(150),
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
                            color: Theme.of(context).colorScheme.surfaceDim,
                            size: width * 0.065,
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
                        color: Theme.of(context).colorScheme.surfaceDim,
                        fontFamily: "Courier",
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

//===============================================================================
//================================= NOTES LIST ==================================
//===============================================================================
                  Expanded(
                    child: ListView.builder(
                      itemCount: noteController.filteredNotesList.length,
                      itemBuilder: (context, index) {
                        final reversedIndex =
                            noteController.filteredNotesList.length - 1 - index;
                        final note =
                            noteController.filteredNotesList[reversedIndex];
                        final realIndex =
                            noteController.allNotesList.indexOf(note);

                        return Padding(
                          padding: EdgeInsets.only(bottom: width * 0.03),
                          child: NoteCard(
                            id: note.id, // Pass Drift ID
                            index: realIndex,
                            width: width,
                            title: note.title,
                            content: note.content,
                            editedDate:
                                "${"edited".tr()}: ${note.date} ${note.time}",
                            color: ItemsColor.itemsColor[
                                reversedIndex % ItemsColor.itemsColor.length],
                            reTime: note.nDate == "Date" || note.nDate == null
                                ? "${"reminder_time".tr()}: ${"not_specified".tr()}"
                                : "${"reminder_time".tr()}: ${note.nDate} ${note.nTime}",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Get.to(
            const AddNoteScreen(),
            transition: Transition.circularReveal,
            arguments: ['', '', ''],
          )?.then((value) {});
          noteController.initialDateTime();
        },
        child: Icon(
          Icons.add_rounded,
          size: width * 0.08,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
