import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/features/note/view/add_note_view.dart';
import 'package:notes/core/widgets/circle_container.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/note/controller/note_controller.dart';

class NoteCard extends StatelessWidget {
  final int index;
  final double width;
  final String title;
  final String content;
  final String editedDate;
  final String reTime;
  final Color? color;

  const NoteCard({
    super.key,
    required this.width,
    required this.index,
    required this.title,
    required this.content,
    required this.editedDate,
    required this.reTime,
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
//===============================================================================
//================================= NOTE TITLE ==================================
//===============================================================================
                    Expanded(
                      flex: 2,
                      child: TextWidget(
                        width: width,
                        text: title,
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
//===============================================================================
//================================= NOTE TEXT ===================================
//===============================================================================
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        height: width * 0.21,
                        width: width * 0.6,
                        child: Text(
                          content,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontFamily: "Courier",
                                    fontSize: width * 0.035,
                                  ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
//===============================================================================
//================================= NOTED TIME ==================================
//===============================================================================
                          TextWidget(
                            width: width,
                            text: editedDate,
                            fontSize: width * 0.025,
                          ),
//===============================================================================
//================================= ALARM TIME ==================================
//===============================================================================
                          TextWidget(
                            width: width,
                            text: reTime,
                            fontSize: width * 0.025,
                          ),
                        ],
                      ),
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
//===============================================================================
//================================ EDIT BUTTON ==================================
//===============================================================================
                    CircleContainer(
                      icon: Icons.edit,
                      width: width,
                      color: Colors.cyan[100]!,
                      onPressed: () {
                        final NoteController noteController = Get.find();
                        Get.to(
                          const AddNoteScreen(),
                          arguments: [index, title, content],
                        );
                        noteController.initialDateTime();
                        noteController.updateNoteLength(content);
                      },
                    ),
//===============================================================================
//============================ NOTIFICATION BUTTON ==============================
//===============================================================================
                    CircleContainer(
                      icon: Icons.alarm,
                      width: width,
                      color: Colors.cyan[100]!,
                      onPressed: () {},
                    ),
//===============================================================================
//=============================== DELETE BUTTON =================================
//===============================================================================
                    CircleContainer(
                      icon: Icons.delete,
                      width: width,
                      color: Colors.cyan[100]!,
                      onPressed: () {
                        NoteController noteController = Get.find();
                        noteController.deleteNoteAt(index);
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
