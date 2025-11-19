import 'package:design_sandbox/features/editor/providers/rendered_output_provider.dart';
import 'package:design_sandbox/features/sandbox/providers/style_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomPreview extends ConsumerWidget {
  const BottomPreview({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(renderedOutputProvider);
  }
}
