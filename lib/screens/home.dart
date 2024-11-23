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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Obx(
        () {
          if (themeController.allNotesList.isEmpty) {
            return Center(
              child: Text(
                "Notes mavjud emas",
                style: TextStyle(
                  fontSize: width * 0.05,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
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
                  SearchBar(
                    shadowColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context)
                          .colorScheme
                          .secondary, 
                    ),
                    hintText: "Search notes...",
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary, 
                        fontFamily: "Courier",
                      ),
                    ),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary, 
                        fontFamily: "Courier",
                      ),
                    ),
                  ),
//=============================================================================== 
//================================ NOTES CARD =================================== 
//=============================================================================== 
                  Expanded(
                    child: ListView.builder(
                      itemCount: themeController.allNotesList.length,
                      itemBuilder: (context, index) {
                        return NoteCard(
                          index: index,
                          width: width,
                          title: themeController.allNotesList[index]['title'],
                          content: themeController.allNotesList[index]
                              ['content'],
                          editedDate:
                              "Edited: ${themeController.allNotesList[index]['date']} ${themeController.allNotesList[index]['time']}",
                          color: ItemsColor
                              .itemsColor[index % ItemsColor.itemsColor.length],
                              reTime: "Reminder time: ${themeController.allNotesList[index]['date']} ${themeController.allNotesList[index]['time']}",
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
//=============================================================================== 
//=============================== ADD NOTE BTN ================================== 
//=============================================================================== 
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor:
            Theme.of(context).colorScheme.secondary, 
        onPressed: () {
          Get.to(
            const AddNoteScreen(),
            transition: Transition.circularReveal,
            duration: const Duration(milliseconds: 1000),
            arguments: ['', '', ''],
          )?.then(
            (value) {
              themeController.readNotes();
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
