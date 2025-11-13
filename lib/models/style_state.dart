import 'package:flutter/material.dart';

class StyleState {
  StyleState({required this.backgroundColor, required this.borderRadius});

  final Color backgroundColor;
  final double borderRadius;

  factory StyleState.initial({Color? backgroundColor, double? borderRadius}) {
    return StyleState(
      backgroundColor: backgroundColor ?? Colors.blue,
      borderRadius: borderRadius ?? 15,
    );
  }
  StyleState copyWith({Color? backgroundColor, double? borderRadius}) {
    return StyleState(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
