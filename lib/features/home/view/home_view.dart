import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/const/item_colors.dart';
import 'package:notes/core/widgets/circle_container.dart';
import 'package:notes/core/widgets/notes_card.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/note/controller/note_controller.dart';
import 'package:notes/features/note/view/add_note_view.dart';
import 'package:notes/features/settings/view/settings_view.dart';
import 'package:notes/data/models/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteController noteController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final RxList<NoteModel> filteredNotesList = <NoteModel>[].obs;

  @override
  void initState() {
    super.initState();

    filteredNotesList.assignAll(noteController.allNotesList);

    searchController.addListener(() {
      filterNotes();
    });

    ever(noteController.allNotesList, (_) {
      filterNotes();
    });
  }

  void filterNotes() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredNotesList.assignAll(noteController.allNotesList);
    } else {
      filteredNotesList.assignAll(
        noteController.allNotesList.where((note) {
          final title = note.title.toLowerCase();
          return title.contains(query);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Obx(
        () {
          if (filteredNotesList.isEmpty) {
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
                            text: "Reminder Notes",
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
                                duration: const Duration(milliseconds: 1000),
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
                        decoration: InputDecoration(
                          hintText: "Search notes...",
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
                        "Reminder notes not found",
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
                          text: "Reminder Notes",
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
                              duration: const Duration(milliseconds: 1000),
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
                      decoration: InputDecoration(
                        hintText: "Search notes...",
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
                      itemCount: filteredNotesList.length,
                      itemBuilder: (context, index) {
                        final reversedIndex =
                            filteredNotesList.length - 1 - index;
                        final note = filteredNotesList[reversedIndex];
                        return Padding(
                          padding: EdgeInsets.only(bottom: width * 0.03),
                          child: NoteCard(
                            index: reversedIndex,
                            width: width,
                            title: note.title,
                            content: note.content,
                            editedDate: "Edited: ${note.date} ${note.time}",
                            color: ItemsColor.itemsColor[
                                reversedIndex % ItemsColor.itemsColor.length],
                            reTime: note.nDate == "Date"
                                ? "Reminder time: Not specified"
                                : "Reminder time: ${note.nDate} ${note.nTime}",
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
            duration: const Duration(milliseconds: 1000),
            arguments: ['', '', ''],
          )?.then(
            (value) {
              noteController.readNotes();
              // filteredNotesList will update via ever() listener
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
