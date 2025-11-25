import 'package:design_sandbox/features/compiler_providers/editor_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_sandbox/features/UI/theme_constants.dart';

class EditorPane extends ConsumerWidget {
  const EditorPane({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var inputController = TextEditingController();
    var editorText = inputController.text;

    return Container(
      decoration: BoxDecoration(
        color: panelBgDark, // dark surface
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),

      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFACC15),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "main.dsl",
                style: TextStyle(color: textMutedOnDark, fontSize: 12),
              ),
              const Spacer(),
              Text(
                "EDITOR",
                style: TextStyle(
                  color: textMutedOnDark.withOpacity(0.8),
                  fontSize: 11,
                  letterSpacing: 0.9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Scrollbar(
              child: TextField(
                controller: inputController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  color: textOnDark,
                  fontFamily: 'monospace', // swap later with JetBrains Mono
                  fontSize: 13.5,
                  height: 1.4,
                ),
                cursorColor: accent,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
                onChanged: (value) {
                  editorText = value;
                  ref.read(editorTextProvider.notifier).update(editorText);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
