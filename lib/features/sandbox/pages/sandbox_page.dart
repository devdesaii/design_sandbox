import 'package:design_sandbox/features/sandbox/providers/split_ratio_provider.dart';
import 'package:design_sandbox/features/sandbox/widgets/bottom_preview.dart';
import 'package:design_sandbox/features/sandbox/widgets/resizeable_split.dart';
import 'package:design_sandbox/features/sandbox/widgets/top_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SandboxPage extends ConsumerWidget {
  const SandboxPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    double adjustedHeight = screenHeight * ref.watch(splitRatioProvider);
    final double topPaneHeight = adjustedHeight;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopControls(height: topPaneHeight),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: (details) {
                ref
                    .read(splitRatioProvider.notifier)
                    .updateRatio(details.delta.dy, screenHeight);
              },
              child: ResizeableSplit(),
            ),
            Expanded(child: BottomPreview()),
          ],
        ),
      ),
    );
  }
}
