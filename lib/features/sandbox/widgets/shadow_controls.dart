import 'package:design_sandbox/features/sandbox/providers/style_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class ShadowControls extends ConsumerWidget {
  const ShadowControls({super.key});
  @override
  Widget build(context, ref) {
    final containerControl = ref.watch(styleProvider);
    print(ref.watch(styleProvider).shadowEnabled);
    if (ref.watch(styleProvider).shadowEnabled == false) {
      return ElevatedButton(
        onPressed: () {
          ref
              .read(styleProvider.notifier)
              .updateShadowEnabled(!ref.watch(styleProvider).shadowEnabled);
        },
        child: Text("Toggle shadow control"),
      );
    }
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ref
                .read(styleProvider.notifier)
                .updateShadowEnabled(!ref.watch(styleProvider).shadowEnabled);
          },
          child: Text("Toggle shadow control"),
        ),
        Slider(
          value: ref.watch(styleProvider).shadowOffsetX,
          min: -50,
          max: 50,
          label: "Shadow Offset X",
          onChanged: (value) {
            ref.read(styleProvider.notifier).updateShadowOffsetX(value);
          },
        ),
        Slider(
          value: ref.watch(styleProvider).shadowOffsetY,
          min: -50,
          max: 50,
          label: "Shadow Offset Y",
          onChanged: (value) {
            ref.read(styleProvider.notifier).updateShadowOffsetY(value);
          },
        ),
        Slider(
          value: ref.watch(styleProvider).shadowBlur,
          min: 0,
          max: 80,
          label: "Shadow  Blur",
          onChanged: (value) {
            ref.read(styleProvider.notifier).updateShadowBlur(value);
          },
        ),
        Slider(
          value: ref.watch(styleProvider).shadowOpacity,
          min: 0.0,
          max: 1.0,
          label: "Border Radius",
          onChanged: (value) {
            ref.read(styleProvider.notifier).updateShadowOpacity(value);
          },
        ),
        ElevatedButton(
          onPressed: () async {
            final Color? newColor = await showColorPickerDialog(
              context,
              containerControl.shadowColor,
              title: Text("Select a color"),
              enableShadesSelection: true,
              colorCodeHasColor: true,
              pickersEnabled: {ColorPickerType.wheel: true},
            );
            if (newColor != null) {
              ref.read(styleProvider.notifier).updateShadowColor(newColor);
            }
          },
          child: Text("Pick a color"),
        ),
      ],
    );
  }
}
