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
                        top: width * 0.08,
                        bottom: width * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            width: width,
                            text: "app_title".tr(),
                            fontSize: width * 0.075,
                            fontWeight: FontWeight.w600,
                            textColor: Theme.of(context).colorScheme.secondary,
                          ),
                          CircleContainer(
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
                        ],
                      ),
                    ),
                    //===============================================================================
//================================= SEARCH BAR ==================================
//===============================================================================
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) {
                          noteController.searchQuery.value = val;
                        },
                        decoration: InputDecoration(
                          hintText: "search".tr(),
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Courier",
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Theme.of(context).colorScheme.surfaceDim,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                            vertical: width * 0.03,
                          ),
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surfaceDim,
                          fontFamily: "Courier",
                        ),
                      ),
                    ),
                    SizedBox(height: width * 0.35),
                    Container(
                      alignment: Alignment.center,
                      height: width * 0.5,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/icons/not-available.png"),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(height: width * 0.05),
                    Center(
                      child: Text(
                        "no_notes".tr(),
                        style: TextStyle(
                          fontSize: width * 0.05,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
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
                      top: width * 0.07,
                      bottom: width * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          width: width,
                          text: "app_title".tr(),
                          fontSize: width * 0.075,
                          fontWeight: FontWeight.w600,
                          textColor: Theme.of(context).colorScheme.secondary,
                        ),
                        CircleContainer(
                          icon: Icons.settings_outlined,
                          width: width,
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () {
                            Get.to(
                              const SettingScreen(),
                              transition: Transition.circularReveal,
                              // duration: const Duration(milliseconds: 1000), // REMOVED slow duration
                              arguments: ['', '', ''],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
//===============================================================================
//================================= SEARCH BAR ==================================
//===============================================================================
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (val) {
                        noteController.searchQuery.value = val;
                      },
                      decoration: InputDecoration(
                        hintText: "search".tr(),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: "Courier",
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Theme.of(context).colorScheme.surfaceDim,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: width * 0.03,
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surfaceDim,
                        fontFamily: "Courier",
                      ),
                    ),
                  ),

//===============================================================================
//================================= NOTES LIST ==================================
//===============================================================================
                  Expanded(
                    child: ListView.builder(
                      // Use controller's filtered list
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
                            index: realIndex,
                            width: width,
                            title: note.title,
                            content: note.content,
                            editedDate:
                                "${"edited".tr()}: ${note.date} ${note.time}",
                            color: ItemsColor.itemsColor[
                                reversedIndex % ItemsColor.itemsColor.length],
                            reTime: note.nDate == "Date"
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
            // duration: const Duration(milliseconds: 1000), // REMOVED slow duration
            arguments: ['', '', ''],
          )?.then(
            (value) {
              // noteController.readNotes(); // REMOVED: Auto synced via reactive lists
            },
          );
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
