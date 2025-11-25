import 'package:design_sandbox/features/compiler_providers/rendered_output_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_sandbox/features/UI/theme_constants.dart';

class PreviewPane extends ConsumerWidget {
  const PreviewPane({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = ref.watch(renderedOutputProvider);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black54),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.play_arrow_rounded, size: 18, color: accent),
              const SizedBox(width: 6),
              const Text(
                "Live Preview",
                style: TextStyle(
                  color: textOnDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                "auto-render",
                style: TextStyle(color: textMutedOnDark, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: panelBgLight,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: preview, 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
