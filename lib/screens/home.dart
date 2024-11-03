import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/const/item_colors.dart';
import 'package:notes/functions/add_read_delete.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/screens/add_note.dart';
import 'package:notes/widgets/circle_container.dart';
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
                      CircleContainer(
                        icon: Icons.clear_all_sharp,
                        width: width,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SearchBar(
                shadowColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onPrimary,
                ),
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
              SizedBox(height: width * 0.02),
              TextWidget(
                width: width,
                text: "Get Storage dagi ma'lumot",
                fontSize: width * 0.05,
              ),
              TextButton(
                onPressed: () {
                  themeController.changeTheme();
                },
                child: TextWidget(
                  width: width,
                  text: "---------",
                  fontSize: 24.0,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ItemsColor.itemsColor.length,
                  itemBuilder: (context, index) {
                    return NoteCard(
                      width: width,
                      title: 'Recipes to Try',
                      items: ['Chicken Alfredo', 'Vegan chili'],
                      editedDate: 'Edited: Sun Jan 2, 2022 10:05 AM',
                      color: ItemsColor.itemsColor[index],
                    );
                  },
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
          size: width * 0.09,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
