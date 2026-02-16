import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart' hide Trans;
import 'package:notes/core/const/app_constants.dart';
import 'package:notes/core/widgets/notification_dialog.dart';
import 'package:notes/core/widgets/text_formatting_toolbar.dart';
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
  late QuillController _quillController;
  final FocusNode _editorFocusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _editorFocusNode.addListener(_onFocusChange);

    if (Get.arguments != null && Get.arguments.length >= 3) {
      if (Get.arguments[0] is int) {
        _titleController = TextEditingController(text: Get.arguments[1] ?? '');
        // Try to load existing content as Delta JSON, fallback to plain text
        final content = Get.arguments[2] ?? '';
        _quillController = _createQuillController(content);
      } else {
        _titleController = TextEditingController();
        _quillController = QuillController.basic();
      }
    } else {
      _titleController = TextEditingController();
      _quillController = QuillController.basic();
    }

    _quillController.addListener(_onContentChanged);
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
      );
    } catch (_) {
      // Plain text fallback
      final doc = Document()..insert(0, content);
      return QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = _editorFocusNode.hasFocus;
    });
  }

  void _onContentChanged() {
    final NoteController noteController = Get.find();
    noteController.updateNoteLength(_quillController.document.toPlainText());
  }

  String _getContentAsJson() {
    return jsonEncode(_quillController.document.toDelta().toJson());
  }

  String _getPlainText() {
    return _quillController.document.toPlainText();
  }

  @override
  void dispose() {
    _editorFocusNode.removeListener(_onFocusChange);
    _editorFocusNode.dispose();
    _titleController.dispose();
    _quillController.removeListener(_onContentChanged);
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final NoteController noteController = Get.find();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceDim,
        toolbarHeight: width * 0.16,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.03),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(width * 0.025),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withAlpha(15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colorScheme.secondary,
                  size: width * 0.05,
                ),
              ),
            ),
          ),
        ),
        title: TextWidget(
          width: width,
          text: "add_note".tr(),
          fontSize: width * 0.055,
          textColor: colorScheme.secondary,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.03),
            child: NotificationDialog(
              width: width,
              noteController: noteController,
              title: _titleController.text,
              text: _getPlainText(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width * 0.04),
//===============================================================================
//================================ TITLE FIELD ==================================
//===============================================================================
            Container(
              decoration: const BoxDecoration(),
              child: TextField(
                cursorColor: colorScheme.secondary,
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "title".tr(),
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: AppConstants.fontFamily,
                        fontSize: width * 0.04,
                        color: colorScheme.inversePrimary.withAlpha(100),
                      ),
                  floatingLabelStyle: TextStyle(
                    fontFamily: "Courier",
                    fontSize: width * 0.035,
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: width * 0.04,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.04, right: width * 0.02),
                    child: Icon(
                      Icons.title_rounded,
                      color: colorScheme.secondary.withAlpha(150),
                      size: width * 0.055,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: width * 0.12),
                ),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: "Courier",
                      color: colorScheme.inversePrimary,
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
                color: colorScheme.secondary.withAlpha(15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: width * 0.035,
                    color: colorScheme.secondary,
                  ),
                  SizedBox(width: width * 0.02),
                  TextWidget(
                    width: width,
                    text:
                        "${noteController.selectedMonth} ${noteController.selectedDate}",
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.w600,
                    textColor: colorScheme.secondary,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.025),
                    height: width * 0.04,
                    width: 1.5,
                    color: colorScheme.secondary.withAlpha(50),
                  ),
                  Icon(
                    Icons.text_fields_rounded,
                    size: width * 0.035,
                    color: colorScheme.secondary,
                  ),
                  SizedBox(width: width * 0.015),
                  Obx(
                    () => TextWidget(
                      width: width,
                      text: "${noteController.noteLength} ${"chars".tr()}",
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w600,
                      textColor: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: width * 0.04),
//===============================================================================
//=============================== CONTENT FIELD =================================
//===============================================================================
            Expanded(
              child: Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: const BoxDecoration(),
                child: QuillEditor(
                  controller: _quillController,
                  focusNode: _editorFocusNode,
                  scrollController: ScrollController(),
                  config: QuillEditorConfig(
                    placeholder: "write".tr(),
                    padding: EdgeInsets.zero,
                    customStyles: DefaultStyles(
                      paragraph: DefaultTextBlockStyle(
                        TextStyle(
                          fontFamily: AppConstants.fontFamily,
                          color: colorScheme.inversePrimary,
                          fontSize: width * 0.04,
                          height: 1.5,
                        ),
                        HorizontalSpacing.zero,
                        VerticalSpacing.zero,
                        VerticalSpacing.zero,
                        null,
                      ),
                      placeHolder: DefaultTextBlockStyle(
                        TextStyle(
                          fontFamily: AppConstants.fontFamily,
                          color: colorScheme.inversePrimary.withAlpha(80),
                          fontSize: width * 0.04,
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
            SizedBox(height: width * 0.02),
//===============================================================================
//============================= FORMATTING TOOLBAR ==============================
//===============================================================================
            if (_isKeyboardVisible)
              RichTextFormattingToolbar(
                controller: _quillController,
                width: width,
                colorScheme: colorScheme,
              ),
            SizedBox(height: width * 0.03),
//===============================================================================
//================================ SAVE BUTTON ==================================
//===============================================================================
            GestureDetector(
              onTap: () async {
                DateTime dateTime = DateTime.now();

                if (Get.arguments != null &&
                    Get.arguments.length >= 3 &&
                    Get.arguments[0] is int) {
                  final int id = Get.arguments[0];
                  await noteController.updateNotes(
                    id: id,
                    title: _titleController.text,
                    content: _getContentAsJson(),
                    date:
                        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}",
                    time:
                        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
                    nDate: noteController.notificationDate.value,
                    nTime: noteController.notificationTime.value,
                    today:
                        "${noteController.selectedMonth} ${noteController.selectedDate}",
                  );
                } else {
                  await noteController.addNotes(
                    title: _titleController.text,
                    content: _getContentAsJson(),
                    date:
                        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}",
                    time:
                        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
                    nDate: noteController.notificationDate.value,
                    nTime: noteController.notificationTime.value,
                    today:
                        "${noteController.selectedMonth} ${noteController.selectedDate}",
                  );
                }

                Navigator.of(context).pop();
                noteController.updateNoteLength('');
              },
              child: Container(
                height: width * 0.14,
                width: width,
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.secondary.withAlpha(50),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save_rounded,
                      color: colorScheme.onSecondary,
                      size: width * 0.06,
                    ),
                    SizedBox(width: width * 0.03),
                    TextWidget(
                      width: width,
                      text: "save".tr(),
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w700,
                      textColor: colorScheme.onSecondary,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: width * 0.08),
          ],
        ),
      ),
    );
  }
}
