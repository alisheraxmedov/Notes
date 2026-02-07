import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart' hide Trans;
import 'package:notes/features/note/view/add_note_view.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/note/controller/note_controller.dart';

class NoteCard extends StatefulWidget {
  final int id;
  final int index;
  final double width;
  final String title;
  final String content;
  final String editedDate;
  final String reTime;
  final Color? color;

  const NoteCard({
    super.key,
    required this.id,
    required this.width,
    required this.index,
    required this.title,
    required this.content,
    required this.editedDate,
    required this.reTime,
    this.color,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late QuillController _quillController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _quillController = _createQuillController(widget.content);
  }

  @override
  void didUpdateWidget(covariant NoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content) {
      _quillController = _createQuillController(widget.content);
    }
  }

  QuillController _createQuillController(String content) {
    if (content.isEmpty) {
      return QuillController.basic();
    }
    try {
      final json = jsonDecode(content);
      final doc = Document.fromJson(json);
      return QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      );
    } catch (_) {
      // Plain text fallback
      final doc = Document()..insert(0, content);
      return QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      );
    }
  }

  String _getPlainTextFromContent(String content) {
    if (content.isEmpty) return '';
    try {
      final json = jsonDecode(content) as List;
      final buffer = StringBuffer();
      for (final op in json) {
        if (op is Map && op['insert'] is String) {
          buffer.write(op['insert']);
        }
      }
      return buffer.toString().trim();
    } catch (_) {
      return content;
    }
  }

  @override
  void dispose() {
    _quillController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _showReminderDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final NoteController noteController = Get.find();
    noteController.initialDateTime();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: colorScheme.surface,
          title: TextWidget(
            width: widget.width,
            text: "set_reminder".tr(),
            fontSize: widget.width * 0.05,
            fontWeight: FontWeight.w700,
            textColor: colorScheme.inversePrimary,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: dialogContext,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    noteController.setNotificationDate(picked);
                  }
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    height: widget.width * 0.12,
                    width: widget.width * 0.3,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withAlpha(15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.secondary.withAlpha(40),
                        width: 1.5,
                      ),
                    ),
                    child: TextWidget(
                      width: widget.width,
                      text: "${noteController.notificationDate}",
                      fontSize: widget.width * 0.035,
                      fontWeight: FontWeight.w600,
                      textColor: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: widget.width * 0.02),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: dialogContext,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    noteController.setNotificationTime(picked);
                  }
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    height: widget.width * 0.12,
                    width: widget.width * 0.3,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withAlpha(15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.secondary.withAlpha(40),
                        width: 1.5,
                      ),
                    ),
                    child: TextWidget(
                      width: widget.width,
                      text: "${noteController.notificationTime}",
                      fontSize: widget.width * 0.035,
                      fontWeight: FontWeight.w600,
                      textColor: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: TextWidget(
                width: widget.width,
                text: "close".tr(),
                fontSize: widget.width * 0.04,
                fontWeight: FontWeight.w500,
                textColor: colorScheme.inversePrimary.withAlpha(150),
              ),
            ),
            TextButton(
              onPressed: () {
                final selectedDate = noteController.notificationDate.value;
                final selectedTime = noteController.notificationTime.value;

                if (selectedDate != "Date" && selectedTime != "Time") {
                  final dateParts =
                      selectedDate.split('-').map(int.parse).toList();
                  final timeParts =
                      selectedTime.split(':').map(int.parse).toList();
                  final scheduledDateTime = DateTime(
                    dateParts[0],
                    dateParts[1],
                    dateParts[2],
                    timeParts[0],
                    timeParts[1],
                  );

                  if (scheduledDateTime.isAfter(DateTime.now())) {
                    noteController.updateNoteReminder(
                      widget.id,
                      selectedDate,
                      selectedTime,
                    );
                    noteController.scheduleNotification(
                      title: widget.title,
                      text: _getPlainTextFromContent(widget.content),
                    );
                    Navigator.of(dialogContext).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("error_time".tr())),
                    );
                  }
                }
              },
              child: TextWidget(
                width: widget.width,
                text: "ok".tr(),
                fontSize: widget.width * 0.04,
                fontWeight: FontWeight.w600,
                textColor: colorScheme.secondary,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.width * 0.015),
      decoration: BoxDecoration(
        color: widget.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.width * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Content
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
//===============================================================================
//================================= NOTE TITLE ==================================
//===============================================================================
                  TextWidget(
                    width: widget.width,
                    text: widget.title,
                    fontSize: widget.width * 0.055,
                    fontWeight: FontWeight.w700,
                    textColor: colorScheme.secondary,
                  ),
                  SizedBox(height: widget.width * 0.02),
//===============================================================================
//================================= NOTE TEXT ===================================
//===============================================================================
                  SizedBox(
                    height: widget.width *
                        0.035 *
                        1.4 *
                        3, // Approx 3 lines: fontSize * height * lines
                    child: ClipRect(
                      child: QuillEditor(
                        controller: _quillController,
                        focusNode: _focusNode,
                        scrollController: ScrollController(),
                        config: QuillEditorConfig(
                          autoFocus: false,
                          expands: false,
                          padding: EdgeInsets.zero,
                          scrollable: false,
                          enableInteractiveSelection: false,
                          enableSelectionToolbar: false,
                          showCursor: false,
                          customStyles: DefaultStyles(
                            paragraph: DefaultTextBlockStyle(
                              TextStyle(
                                fontFamily: "Courier",
                                color: colorScheme.inversePrimary,
                                fontSize: widget.width * 0.035,
                                height: 1.4,
                              ),
                              HorizontalSpacing.zero,
                              VerticalSpacing.zero,
                              VerticalSpacing.zero,
                              null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: widget.width * 0.03),
                  Divider(
                    color: colorScheme.secondary.withAlpha(30),
                    thickness: 1,
                  ),
                  SizedBox(height: widget.width * 0.02),
//===============================================================================
//================================= META INFO ===================================
//===============================================================================
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: widget.width * 0.035,
                        color: colorScheme.secondary.withAlpha(150),
                      ),
                      SizedBox(width: widget.width * 0.015),
                      Expanded(
                        child: TextWidget(
                          width: widget.width,
                          text: widget.editedDate,
                          fontSize: widget.width * 0.028,
                          textColor: colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                  if (widget.reTime.isNotEmpty &&
                      !widget.reTime.contains("not_specified")) ...[
                    SizedBox(height: widget.width * 0.015),
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                          size: widget.width * 0.035,
                          color: colorScheme.secondary.withAlpha(150),
                        ),
                        SizedBox(width: widget.width * 0.015),
                        Expanded(
                          child: TextWidget(
                            width: widget.width,
                            text: widget.reTime,
                            fontSize: widget.width * 0.028,
                            textColor: colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: widget.width * 0.03),
            // Right side - Action buttons
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
//===============================================================================
//================================ EDIT BUTTON ==================================
//===============================================================================
                _buildActionButton(
                  context: context,
                  icon: Icons.edit_outlined,
                  color: colorScheme.secondary,
                  onPressed: () {
                    final NoteController noteController = Get.find();
                    Get.to(
                      const AddNoteScreen(),
                      arguments: [widget.id, widget.title, widget.content],
                    );
                    noteController.initialDateTime();
                    noteController.updateNoteLength(
                        _getPlainTextFromContent(widget.content));
                  },
                ),
                SizedBox(height: widget.width * 0.025),
//===============================================================================
//============================ NOTIFICATION BUTTON ==============================
//===============================================================================
                _buildActionButton(
                  context: context,
                  icon: Icons.notifications_outlined,
                  color: colorScheme.secondary,
                  onPressed: () => _showReminderDialog(context),
                ),
                SizedBox(height: widget.width * 0.025),
//===============================================================================
//=============================== DELETE BUTTON =================================
//===============================================================================
                _buildActionButton(
                  context: context,
                  icon: Icons.delete_outline_rounded,
                  color: Colors.red.shade400,
                  onPressed: () {
                    NoteController noteController = Get.find();
                    noteController.deleteNote(widget.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(widget.width * 0.025),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: widget.width * 0.055,
          color: color,
        ),
      ),
    );
  }
}
