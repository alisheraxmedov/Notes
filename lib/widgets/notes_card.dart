import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/screens/add_note.dart';
import 'package:notes/widgets/circle_container.dart';
import 'package:notes/widgets/text.dart';

class NoteCard extends StatelessWidget {
  final int index;
  final double width;
  final String title;
  final String content;
  final String editedDate;
  final Color? color;

  const NoteCard({
    super.key,
    required this.width,
    required this.index,
    required this.title,
    required this.content,
    required this.editedDate,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.symmetric(
        vertical: width * 0.02,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: width * 0.02,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                height: width * 0.44,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      width: width,
                      text: title,
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: width * 0.21,
                      width: width * 0.6,
                      // color: ColorClass.blue,
                      child: Text(
                        content,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontFamily: "Courier",
                                  fontSize: width * 0.035,
                                ),
                      ),
                    ),
                    Text(
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontFamily: "Courier",
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: width * 0.03,
                          ),
                      editedDate,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: width * 0.44,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleContainer(
                      icon: Icons.edit,
                      width: width,
                      color: Colors.cyan[100]!,
                      onPressed: () {
                        Get.to(
                          const AddNoteScreen(),
                          arguments: [index, title, content],
                        );
                      },
                    ),
                    CircleContainer(
                      icon: Icons.alarm,
                      width: width,
                      color: Colors.cyan[100]!,
                      onPressed: () {},
                    ),
                    CircleContainer(
                      icon: Icons.delete,
                      width: width,
                      color: Colors.cyan[100]!,
                      onPressed: () {
                        GetXController themeController = Get.find();
                        themeController.deleteSelectedNotes(title: title);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
