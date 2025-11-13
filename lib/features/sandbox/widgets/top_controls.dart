import 'package:design_sandbox/features/sandbox/providers/style_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopControls extends ConsumerWidget {
  const TopControls({required this.height, super.key});
  final double height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentColor = ref.watch(styleProvider);
    var safeHeight = height.clamp(120, double.infinity).toDouble();

    return Container(
      height: safeHeight,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Column(
          children: [
            Text("Current Color:"),
            SizedBox(
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(color: currentColor.backgroundColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(styleProvider.notifier).updateColor();
                ref.read(styleProvider.notifier).updateRadius();
              },
              child: Text("Change Color to red"),
            ),
          ],
        ),
      ),
    );
  }
}
