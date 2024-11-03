import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/screens/add_note.dart';
import 'package:notes/widgets/notes_card.dart';
import 'package:notes/widgets/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final GetXController themeController = Get.find();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.onPrimary,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            width * 0.03,
          ),
          child: Column(
            children: [
              SizedBox(
                child: Padding(
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
                      ),
                      Container(
                        height: width * 0.12,
                        width: width * 0.12,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SearchBar(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
                hintText: "Search notes...",
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: "Courier",
                  ),
                ),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: "Courier",
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  children: [
                    NoteCard(
                      title: 'Recipes to Try',
                      items: ['Chicken Alfredo', 'Vegan chili'],
                      editedDate: 'Edited: Sun Jan 2, 2022 10:05 AM',
                      color: Colors.blue[100],
                    ),
                    NoteCard(
                      title: 'Gift Ideas for Mom',
                      items: ['Jewelry box', 'Cookbook'],
                      editedDate: 'Edited: Wed Jan 4, 2023 4:53 PM',
                      color: Colors.pink[100],
                    ),
                    NoteCard(
                      title: 'Bucket List',
                      items: ['Travel to Japan', 'Learn to play the guitar'],
                      editedDate: 'Edited: Fri Jan 6, 2023 1:09 PM',
                      color: Colors.yellow[100],
                    ),
                    NoteCard(
                      title: 'Ideas for Vacation',
                      items: [
                        'Visit Grand Canyon',
                        'Go on a hot air balloon ride'
                      ],
                      editedDate: 'Edited: Wed Feb 1, 2023 12:34 PM',
                      color: Colors.pink[100],
                    ),
                    NoteCard(
                      title: 'Meeting Notes',
                      items: ['Attendees: John, Mary, David', 'Agenda:'],
                      editedDate: 'Edited: Wed Feb 1, 2023 12:34 PM',
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Get.to(
            const AddNoteScreen(),
            transition: Transition.circularReveal,
            duration: const Duration(milliseconds: 1000),
          );
          themeController.initialDateTime();
        },
        child: Icon(
          Icons.add,
          size: width * 0.05,
        ),
      ),
    );
  }
}
