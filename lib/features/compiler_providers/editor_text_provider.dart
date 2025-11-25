import 'package:flutter_riverpod/flutter_riverpod.dart';

final editorTextProvider = NotifierProvider<EditorTextNotifier, String>(
  EditorTextNotifier.new,
);

class EditorTextNotifier extends Notifier<String> {
  String starterCode = "";
  @override
  String build() {
    return starterCode;
  }

  void update(String text) {
    state = text;
  }

  void saveFromPreset(String code) {
    state = code;
  }
}
