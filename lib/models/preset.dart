import 'package:design_sandbox/models/style_state.dart';

class Preset {
  Preset({required this.name, required this.id, required this.style});
  final String id;
  final String name;
  final StyleState style;

  Preset copyWith({String? name, String? id, StyleState? style}) {
    return Preset(
      name: name ?? this.name,
      id: id ?? this.id,
      style: style ?? this.style,
    );
  }
  //add toJson and fromJson functions later for persistence
  }
