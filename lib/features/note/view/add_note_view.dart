import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
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
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final NoteController noteController = Get.find();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.16,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.02),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Container(
              padding: EdgeInsets.all(width * 0.02),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withAlpha(30),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: width * 0.05,
              ),
            ),
          ),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Theme.of(context).colorScheme.inversePrimary,
              Theme.of(context).colorScheme.inversePrimary.withAlpha(180),
              Theme.of(context).colorScheme.inversePrimary,
            ],
          ).createShader(bounds),
          child: TextWidget(
            width: width,
            text: "add_note".tr(),
            fontSize: width * 0.065,
            textColor: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.secondary.withAlpha(40),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: NotificationDialog(
                width: width,
                noteController: noteController,
                title: _titleController.text,
                text: _contentController.text,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(200),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: width * 0.04),
//===============================================================================
//================================ TITLE FIELD ==================================
//===============================================================================
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "title".tr(),
                    labelStyle:
                        Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontFamily: "Courier",
                              fontSize: width * 0.04,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(150),
                            ),
                    floatingLabelStyle: TextStyle(
                      fontFamily: "Courier",
                      fontSize: width * 0.035,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: width * 0.04,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.03, right: width * 0.02),
                      child: Icon(
                        Icons.title_rounded,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withAlpha(180),
                        size: width * 0.055,
                      ),
                    ),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: width * 0.12),
                  ),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: "Courier",
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(height: width * 0.04),
//===============================================================================
//=============================== DATE & CHARS BADGE ============================
//===============================================================================
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: width * 0.025,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.secondary.withAlpha(60),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: width * 0.035,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: width * 0.02),
                    TextWidget(
                      width: width,
                      text:
                          "${noteController.selectedMonth} ${noteController.selectedDate}",
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.025),
                      height: width * 0.04,
                      width: 1.5,
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(100),
                    ),
                    Icon(
                      Icons.text_fields_rounded,
                      size: width * 0.035,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: width * 0.015),
                    Obx(
                      () => TextWidget(
                        width: width,
                        text: "${noteController.noteLength} ${"chars".tr()}",
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: width * 0.05),
//===============================================================================
//=============================== CONTENT FIELD =================================
//===============================================================================
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    controller: _contentController,
                    onChanged: (value) {
                      noteController.updateNoteLength(value.toString());
                    },
                    decoration: InputDecoration(
                      hintText: "write".tr(),
                      hintStyle:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontFamily: "Courier",
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withAlpha(120),
                                fontSize: width * 0.04,
                              ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(width * 0.04),
                    ),
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontFamily: "Courier",
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: width * 0.04,
                          height: 1.5,
                        ),
                  ),
                ),
              ),
              SizedBox(height: width * 0.05),
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
                  height: width * 0.14,
                  width: width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withAlpha(100),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save_rounded,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: width * 0.06,
                      ),
                      SizedBox(width: width * 0.03),
                      TextWidget(
                        width: width,
                        text: "save".tr(),
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.w700,
                        textColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: width * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
