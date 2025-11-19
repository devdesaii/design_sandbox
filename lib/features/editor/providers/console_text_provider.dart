import 'package:flutter_riverpod/flutter_riverpod.dart';

final consoleTextProvider = NotifierProvider<ConsoleTextNotifier, List<String>>(
  ConsoleTextNotifier.new,
);

class ConsoleTextNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }
  update(String value){
    state = [...state, value];
  }
}
