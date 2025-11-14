import 'package:flutter/material.dart';

class StyleState {
  StyleState({
    required this.backgroundColor,
    required this.borderRadius,
    required this.shadowBlur,
    required this.shadowColor,
    required this.shadowEnabled,
    required this.shadowOffsetX,
    required this.shadowOffsetY,
    required this.shadowOpacity,
  });

  final Color backgroundColor;
  final double borderRadius;
  final bool shadowEnabled;
  final double shadowOffsetX;
  final double shadowOffsetY;
  final double shadowBlur;
  final double shadowOpacity;
  final Color shadowColor;
  factory StyleState.initial({
    Color? backgroundColor,
    double? borderRadius,
    double? shadowOffsetX,
    double? shadowOffsetY,
    double? shadowBlur,
    double? shadowOpacity,
    bool? shadowEnabled,
    Color? shadowColor,
  }) {
    return StyleState(
      backgroundColor: backgroundColor ?? Colors.blue,
      borderRadius: borderRadius ?? 15,
      shadowBlur: shadowBlur ?? 0,
      shadowColor: shadowColor ?? Colors.purple,
      shadowEnabled: shadowEnabled ?? false,
      shadowOffsetX: shadowOffsetX ?? 0,
      shadowOffsetY: shadowOffsetY ?? 0,
      shadowOpacity: shadowOpacity ?? 0.5,
    );
  }
  StyleState copyWith({
    Color? backgroundColor,
    double? borderRadius,
    double? shadowOffsetX,
    double? shadowOffsetY,
    double? shadowBlur,
    double? shadowOpacity,
    bool? shadowEnabled,
    Color? shadowColor,
  }) {
    return StyleState(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      shadowBlur: shadowBlur ?? this.shadowBlur,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowEnabled: shadowEnabled ?? this.shadowEnabled,
      shadowOffsetX: shadowOffsetX ?? this.shadowOffsetX,
      shadowOffsetY: shadowOffsetY ?? this.shadowOffsetY,
      shadowOpacity: shadowOpacity ?? this.shadowOpacity,
    );
  }
}
