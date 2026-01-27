import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/widgets/notification_dialog.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/note/controller/note_controller.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
  });

  @override
  AddNoteScreenState createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null && Get.arguments.length >= 3) {
      final String? title = Get.arguments[1];
      final String? content = Get.arguments[2];

      _titleController = TextEditingController(text: title ?? '');
      _contentController = TextEditingController(text: content ?? '');
    } else {
      _titleController = TextEditingController();
      _contentController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final NoteController noteController = Get.find();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.13,
        centerTitle: true,
        title: TextWidget(
          width: width,
          text: "Add Note",
          fontSize: width * 0.09,
          textColor: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          NotificationDialog(
            width: width,
            noteController: noteController,
            title: _titleController.text,
            text: _contentController.text,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            children: [
//===============================================================================
//================================ TITLE FIELD ==================================
//===============================================================================
              TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Enter a title for the note',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontFamily: "Courier", fontSize: width * 0.045),
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: "Courier",
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: width * 0.01),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Row(
                  children: [
                    TextWidget(
                      width: width,
                      text:
                          "${noteController.selectedMonth} ${noteController.selectedDate}",
                      fontSize: width * 0.03,
                    ),
                    TextWidget(
                      width: width,
                      text: " | ",
                      fontSize: width * 0.03,
                    ),
                    Obx(
                      () => TextWidget(
                        width: width,
                        text: "${noteController.noteLength} characters",
                        fontSize: width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: width * 0.02),
//===============================================================================
//=============================== CONTENT FIELD =================================
//===============================================================================
              TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: _contentController,
                onChanged: (value) {
                  noteController.updateNoteLength(value.toString());
                },
                decoration: InputDecoration(
                  labelText: 'Start writing...',
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: "Courier",
                      ),
                  border: InputBorder.none,
                ),
                maxLines: 5,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: "Courier",
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const Spacer(),
//===============================================================================
//================================ SAVE BUTTON ==================================
//===============================================================================
              GestureDetector(
                onTap: () {
                  DateTime dateTime = DateTime.now();
                  final int? index =
                      int.tryParse(Get.arguments[0]?.toString() ?? '');

                  noteController.updateNotes(
                    title: _titleController.text,
                    content: _contentController.text,
                    date: "${dateTime.day}:${dateTime.month}:${dateTime.year}",
                    time: "${dateTime.hour}:${dateTime.minute}",
                    index: index,
                    nDate: noteController.notificationDate.value,
                    nTime: noteController.notificationTime.value,
                    today:
                        "${noteController.selectedMonth} ${noteController.selectedDate}",
                  );
                  Get.back();
                  noteController.updateNoteLength('');
                },
                child: Container(
                  height: width * 0.15,
                  width: width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(width * 0.02),
                  ),
                  alignment: Alignment.center,
                  child: TextWidget(
                    width: width,
                    text: "Save",
                    fontSize: width * 0.09,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              SizedBox(height: width * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}
