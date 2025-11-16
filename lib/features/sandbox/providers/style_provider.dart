import 'package:design_sandbox/models/preset.dart';
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

  void updateColor(Color newColor) {
    state = state.copyWith(backgroundColor: newColor);
  }

  void updateRadius(double value) {
    state = state.copyWith(borderRadius: value);
  }

  void updateShadowOpacity(double value) {
    state = state.copyWith(shadowOpacity: value);
  }

  void updateShadowBlur(double value) {
    state = state.copyWith(shadowBlur: value);
  }

  void updateShadowOffsetX(double value) {
    state = state.copyWith(shadowOffsetX: value);
  }

  void updateShadowOffsetY(double value) {
    state = state.copyWith(shadowOffsetY: value);
  }

  void updateShadowEnabled(bool value) {
    state = state.copyWith(shadowEnabled: value);
  }

  void updateShadowColor(Color value) {
    state = state.copyWith(shadowColor: value);
  }

  void applyStyle(Preset preset) {
    state = preset.style;
  }
}
