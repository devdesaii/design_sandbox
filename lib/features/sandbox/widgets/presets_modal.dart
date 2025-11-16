import 'package:design_sandbox/features/sandbox/providers/presets_provider.dart';
import 'package:design_sandbox/features/sandbox/providers/style_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PresetsModal extends ConsumerStatefulWidget {
  const PresetsModal({super.key});

  @override
  ConsumerState<PresetsModal> createState() => _PresetsModalState();
}

class _PresetsModalState extends ConsumerState<PresetsModal> {
  late final TextEditingController _presetNameController;
  String? errorTextValue;

  @override
  void initState() {
    super.initState();
    _presetNameController = TextEditingController();
  }

  @override
  void dispose() {
    _presetNameController.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    final name = _presetNameController.text.trim();
    if (name.isEmpty) {
      errorTextValue = "Please enter a value";
      return;
    }

    final style = ref.read(styleProvider);
    ref.read(presetsProvider.notifier).savePreset(name, style);

    _presetNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final presets = ref.watch(presetsProvider);

    return Column(
      children: [
        TextField(
          controller: _presetNameController,
          decoration: InputDecoration(
            labelText: "Enter Preset Name",
            errorText: errorTextValue,
          ),
          onSubmitted: (_) => _onSavePressed(),
          onChanged: (value) {
            if (value.trim().isEmpty) {
              setState(() {
                errorTextValue = "Please enter a name";
              });
            }
          },
        ),
        TextButton(onPressed: _onSavePressed, child: const Text("Save")),
        Expanded(
          child: ListView.builder(
            itemCount: presets.length,
            itemBuilder: (context, index) {
              final preset = presets[index];
              return ListTile(
                title: Text(preset.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref.read(styleProvider.notifier).applyStyle(preset);
                      },
                      child: const Text("Apply"),
                    ),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(presetsProvider.notifier)
                            .deletePreset(preset.id);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
