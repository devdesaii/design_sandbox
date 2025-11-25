import 'package:design_sandbox/features/UI/widgets/preview_pane.dart';
import 'package:design_sandbox/features/UI/widgets/editor_pane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 4, child: EditorPane()),
            Expanded(flex: 6, child: PreviewPane()),
          ],
        ),
      ),
    );
  }
}
