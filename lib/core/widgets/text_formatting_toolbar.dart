import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RichTextFormattingToolbar extends StatelessWidget {
  final QuillController controller;
  final double width;
  final ColorScheme colorScheme;

  const RichTextFormattingToolbar({
    super.key,
    required this.controller,
    required this.width,
    required this.colorScheme,
  });

  static final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.black,
  ];

  void _showColorPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(width * 0.05),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width * 0.1,
              height: 4,
              margin: EdgeInsets.only(bottom: width * 0.04),
              decoration: BoxDecoration(
                color: colorScheme.secondary.withAlpha(50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Wrap(
              spacing: width * 0.03,
              runSpacing: width * 0.03,
              children: _colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    final hexColor =
                        '#${color.toARGB32().toRadixString(16).substring(2)}';
                    controller.formatSelection(ColorAttribute(hexColor));
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    width: width * 0.12,
                    height: width * 0.12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withAlpha(100),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: width * 0.05),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.14,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FormatButton(
            icon: Icons.format_bold_rounded,
            attribute: Attribute.bold,
            controller: controller,
            width: width,
            colorScheme: colorScheme,
            tooltip: 'Bold',
          ),
          _FormatButton(
            icon: Icons.format_italic_rounded,
            attribute: Attribute.italic,
            controller: controller,
            width: width,
            colorScheme: colorScheme,
            tooltip: 'Italic',
          ),
          _FormatButton(
            icon: Icons.format_underlined_rounded,
            attribute: Attribute.underline,
            controller: controller,
            width: width,
            colorScheme: colorScheme,
            tooltip: 'Underline',
          ),
          _FormatButton(
            icon: Icons.strikethrough_s_rounded,
            attribute: Attribute.strikeThrough,
            controller: controller,
            width: width,
            colorScheme: colorScheme,
            tooltip: 'Strikethrough',
          ),
          Container(
            height: width * 0.06,
            width: 1.5,
            color: colorScheme.secondary.withAlpha(40),
          ),
          _ColorPickerButton(
            width: width,
            colorScheme: colorScheme,
            onTap: () => _showColorPicker(context),
          ),
        ],
      ),
    );
  }
}

class _FormatButton extends StatelessWidget {
  final IconData icon;
  final Attribute attribute;
  final QuillController controller;
  final double width;
  final ColorScheme colorScheme;
  final String tooltip;

  const _FormatButton({
    required this.icon,
    required this.attribute,
    required this.controller,
    required this.width,
    required this.colorScheme,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final isActive = controller
            .getSelectionStyle()
            .attributes
            .containsKey(attribute.key);

        return Tooltip(
          message: tooltip,
          child: GestureDetector(
            onTap: () {
              if (isActive) {
                controller.formatSelection(Attribute.clone(attribute, null));
              } else {
                controller.formatSelection(attribute);
              }
            },
            child: Container(
              width: width * 0.1,
              height: width * 0.1,
              decoration: BoxDecoration(
                color: isActive ? colorScheme.secondary : colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.secondary,
                  width: isActive ? 2 : 1,
                ),
              ),
              child: Icon(
                icon,
                color:
                    isActive ? colorScheme.onSecondary : colorScheme.secondary,
                size: width * 0.055,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ColorPickerButton extends StatelessWidget {
  final double width;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _ColorPickerButton({
    required this.width,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Color',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width * 0.1,
          height: width * 0.1,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withAlpha(60),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.palette_rounded,
            color: Colors.white,
            size: width * 0.05,
          ),
        ),
      ),
    );
  }
}
