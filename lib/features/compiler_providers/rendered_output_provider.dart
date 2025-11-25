import 'package:design_sandbox/features/compiler_providers/debounce_text_provider.dart';
import 'package:design_sandbox/features/compiler/parser.dart';
import 'package:design_sandbox/features/compiler/renderer.dart';
import 'package:design_sandbox/features/UI/widgets/error_box.dart';
import 'package:design_sandbox/features/compiler/tokenizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final renderedOutputProvider = NotifierProvider<RenderedOutputNotifier, Widget>(
  RenderedOutputNotifier.new,
);

class RenderedOutputNotifier extends Notifier<Widget> {
  @override
  build() {
    try {
      var tokenizerSource = ref.watch(debounceTextProvider);
      final tokenizerInstance = Tokenizer(tokenizerSource);
      var parserInput = tokenizerInstance.tokenize();
      final parserInstance = Parser(parserInput);
      var rendererInput = parserInstance.parseProgram();
      final rendererInstance = Renderer(rendererInput);
      return rendererInstance.render();
    } catch (e) {
      return ErrorBox(e.toString());
    }
  }
}
