import 'package:design_sandbox/features/compiler_providers/editor_text_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

final debounceTextProvider = NotifierProvider<DebounceTextNotifier, String>(
  DebounceTextNotifier.new,
);


class DebounceTextNotifier extends Notifier<String> {
Duration debounceDuration = Duration(milliseconds: 300);
late final ProviderSubscription<String> editorTextProviderSubscription;
bool isSubscribed = false;
  Timer? timer;
  String? lastRawInput;

  @override
  String build() {
    state = ref.read(editorTextProvider);
    if (!isSubscribed) {
      editorTextProviderSubscription = ref.listen<String>(editorTextProvider, (
        previous,
        next,
      ) {
        timer?.cancel();
        timer = Timer(debounceDuration, () {
          if (state != next) {
            state = next;
          }
        });
      }, fireImmediately: false);
    ref.onDispose(() {
      timer?.cancel();
    });
      isSubscribed = true;
    }
    return state;
  }
}
