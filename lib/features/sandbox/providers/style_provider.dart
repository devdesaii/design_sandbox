import 'package:design_sandbox/models/style_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final styleProvider = NotifierProvider<StyleNotifier, StyleState>(
  StyleNotifier.new,
);

class StyleNotifier extends Notifier<StyleState> {
  @override
  StyleState build() {
    return StyleState.initial();
  }

  void updateColor() {
    state = state.copyWith(backgroundColor: Colors.red);
  }

  void updateRadius() {
    state = state.copyWith(borderRadius: 50);
  }
}
