import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_sandbox/models/preset.dart';
import 'package:design_sandbox/models/style_state.dart';

final presetsProvider = NotifierProvider<PresetNotifier, List<Preset>>(
  PresetNotifier.new,
);

class PresetNotifier extends Notifier<List<Preset>> {
  @override
  List<Preset> build() {
    return [];
  }

  String savePreset(String name, StyleState style) {
    final newPreset = Preset(
      id: DateTime.now().toIso8601String(),
      name: name,
      style: style,
    );
    state = [newPreset, ...state];
    return newPreset.id;
  }

  void deletePreset(String id) {
    state = state.where((preset) => preset.id != id).toList();
  }

  StyleState? getPresetStyle(String? id) {
    if (id == null) {
      return null;
    }
    return state
        .where((preset) {
          return preset.id == id;
        })
        .first
        .style;
  }
}
