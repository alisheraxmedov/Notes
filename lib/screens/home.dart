import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/const/item_colors.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/screens/add_note.dart';
import 'package:notes/screens/settings.dart';
import 'package:notes/widgets/circle_container.dart';
import 'package:notes/widgets/notes_card.dart';
import 'package:notes/widgets/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetXController themeController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final RxList filteredNotesList = [].obs;

  @override
  void initState() {
    super.initState();

    filteredNotesList.addAll(themeController.allNotesList);

    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      if (query.isEmpty) {
        filteredNotesList.assignAll(themeController.allNotesList);
      } else {
        filteredNotesList.assignAll(
          themeController.allNotesList.where((note) {
            final title = note['title'].toString().toLowerCase();
            return title.contains(query);
          }),
        );
      }
    });

    ever(themeController.allNotesList, (_) {
      final query = searchController.text.toLowerCase();
      if (query.isEmpty) {
        filteredNotesList.assignAll(themeController.allNotesList);
        searchController.clear();
      } else {
        filteredNotesList.assignAll(
          themeController.allNotesList.where((note) {
            final title = note['title'].toString().toLowerCase();
            return title.contains(query);
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Obx(
        () {
          if (filteredNotesList.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: width * 0.03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
//===============================================================================
//=================================== HEADER ====================================
//===============================================================================
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.01,
                      top: width * 0.07,
                      bottom: width * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          width: width,
                          text: "Notes",
                          fontSize: width * 0.09,
                          fontWeight: FontWeight.bold,
                          textColor: Theme.of(context).colorScheme.secondary,
                        ),
                        CircleContainer(
                          icon: Icons.clear_all_sharp,
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
                  SizedBox(height: width * 0.03),
                  //===============================================================================
                  //================================ SEARCH BAR ===================================
                  //===============================================================================
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search notes...",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: "Courier",
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.surfaceDim,
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surfaceDim,
                      fontFamily: "Courier",
                    ),
                  ),
                  Container(
                    height: width * 0.5,
                    width: width * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/icons/not-available.jpg"),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Such note not available.",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Column(
                children: [
//===============================================================================
//=================================== HEADER ====================================
//===============================================================================
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.01,
                      top: width * 0.07,
                      bottom: width * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          width: width,
                          text: "Notes",
                          fontSize: width * 0.09,
                          fontWeight: FontWeight.bold,
                          textColor: Theme.of(context).colorScheme.secondary,
                        ),
                        CircleContainer(
                          icon: Icons.clear_all_sharp,
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
//================================ SEARCH BAR ===================================
//===============================================================================
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search notes...",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: "Courier",
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontFamily: "Courier",
                    ),
                  ),
//===============================================================================
//================================ NOTES CARD ===================================
//===============================================================================
                  Obx(
                    () {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: filteredNotesList.length,
                          itemBuilder: (context, index) {
                            return NoteCard(
                              index: index,
                              width: width,
                              title: filteredNotesList[index]['title'],
                              content: filteredNotesList[index]['content'],
                              editedDate:
                                  "Edited: ${filteredNotesList[index]['date']} ${filteredNotesList[index]['time']}",
                              color: ItemsColor.itemsColor[
                                  index % ItemsColor.itemsColor.length],
                              reTime: filteredNotesList[index]['nDate'] ==
                                      "Date"
                                  ? "Reminder time: Unspecified"
                                  : "Reminder time: ${filteredNotesList[index]['nDate']} ${filteredNotesList[index]['nTime']}",
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
//===============================================================================
//=============================== ADD NOTE BTN ==================================
//===============================================================================
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
              themeController.readNotes();
              filteredNotesList.assignAll(themeController.allNotesList);
            },
          );
          themeController.initialDateTime();
        },
        child: Icon(
          Icons.add,
          size: width * 0.09,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
