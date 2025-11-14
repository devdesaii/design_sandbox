import 'package:design_sandbox/features/sandbox/widgets/bottom_preview.dart';
import 'package:design_sandbox/features/sandbox/widgets/top_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SandboxPage extends ConsumerWidget {
  const SandboxPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double topPaneHeight = screenHeight * 0.6;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopControls(height: topPaneHeight),
            Expanded(child: BottomPreview()),
          ],
        ),
      ),
    );
  }
}
