import 'dart:async';
import 'package:design_sandbox/features/editor/providers/console_text_provider.dart';
import 'package:design_sandbox/features/editor/providers/editor_text_provider.dart';
import 'package:design_sandbox/features/sandbox/providers/split_ratio_provider.dart';
import 'package:design_sandbox/features/sandbox/providers/style_provider.dart';
import 'package:design_sandbox/features/sandbox/widgets/presets_modal.dart';
import 'package:design_sandbox/features/sandbox/widgets/shadow_controls.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopControls extends ConsumerWidget {
  const TopControls({required this.height, super.key});
  final double height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentColor = ref.watch(styleProvider);
    var safeHeight = height.clamp(120, double.infinity).toDouble();
    var inputController = TextEditingController();
    var editorText = inputController.text;

    return Container(
      height: safeHeight,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(labelText: "Input Code"),
              onChanged: (value) {
                editorText = value;
                ref.read(editorTextProvider.notifier).update(editorText);
              },
            ),
            Text(ref.watch(consoleTextProvider).join("\n")),
          ],
        ),
      ),
    );
  }
}
