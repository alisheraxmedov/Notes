import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:notes/core/const/item_colors.dart';
import 'package:notes/core/utils/date_formatter.dart';
import 'package:notes/core/widgets/notes_card.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/note/controller/note_controller.dart';

/// Screen for displaying missed / overdue notes.
class MissedNotesScreen extends StatelessWidget {
  const MissedNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;
    final NoteController noteController = Get.find();

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: SafeArea(
        child: Obx(() {
          if (noteController.missedNotesList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(width * 0.06),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withAlpha(15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.history_rounded,
                      size: width * 0.15,
                      color: colorScheme.secondary.withAlpha(100),
                    ),
                  ),
                  SizedBox(height: width * 0.06),
                  TextWidget(
                    width: width,
                    text: "missed_notes".tr(),
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                    textColor: colorScheme.secondary,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: width * 0.02),
                  TextWidget(
                    width: width,
                    text: "no_missed_notes".tr(),
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    textColor: colorScheme.inversePrimary.withAlpha(120),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: width * 0.04,
                  bottom: width * 0.05,
                  left: width * 0.05,
                  right: width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      width: width,
                      text: "missed_notes".tr(),
                      fontSize: width * 0.075,
                      fontWeight: FontWeight.w700,
                      textColor: colorScheme.secondary,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: noteController.missedNotesList.length,
                    itemBuilder: (context, index) {
                      final note = noteController.missedNotesList[index];
                      // Use negative index or special handling if needed,
                      // but NoteCard just needs an index for color generation.
                      // We can just use the index here.

                      return NoteCard(
                        id: note.id,
                        index: index,
                        width: width,
                        title: note.title,
                        content: note.content,
                        editedDate:
                            "${"edited".tr()}: ${DateFormatter.formatDate(note.date)} ${note.time}",
                        color: ItemsColor.getColors(context)[
                            index % ItemsColor.getColors(context).length],
                        reTime: note.nDate == "Date" || note.nDate == null
                            ? "${"reminder_time".tr()}: ${"not_specified".tr()}"
                            : "${"reminder_time".tr()}: ${DateFormatter.formatDate(note.nDate)} ${note.nTime}",
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
