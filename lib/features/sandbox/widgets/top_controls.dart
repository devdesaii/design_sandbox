import 'dart:async';
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

    return Container(
      height: safeHeight,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.white),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  return await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return PresetsModal();
                    },
                  );
                },
                child: Text("Presets"),
              ),
              Text("Current Color:"),
              SizedBox(
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: currentColor.backgroundColor,
                  ),
                ),
              ),
              Slider(
                value: ref.watch(styleProvider).borderRadius,
                min: 15,
                max: 200,
                label: "Border Radius",
                onChanged: (value) {
                  ref.read(styleProvider.notifier).updateRadius(value);
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final Color? newColor = await showColorPickerDialog(
                    context,
                    currentColor.backgroundColor,
                    title: Text("Select a color"),
                    enableShadesSelection: true,
                    colorCodeHasColor: true,
                    pickersEnabled: {ColorPickerType.wheel: true},
                  );
                  if (newColor != null) {
                    ref.read(styleProvider.notifier).updateColor(newColor);
                  }
                },
                child: Text("Pick a color"),
              ),
              ShadowControls(),
            ],
          ),
        ),
      ),
    );
  }
}
