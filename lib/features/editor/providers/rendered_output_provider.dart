import 'package:design_sandbox/features/editor/providers/debounce_text_provider.dart';
import 'package:design_sandbox/features/parser/parser.dart';
import 'package:design_sandbox/features/parser/renderer.dart';
import 'package:design_sandbox/features/tokenizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final renderedOutputProvider = NotifierProvider<RenderedOutputNotifier, Widget>(
  RenderedOutputNotifier.new,
);

class RenderedOutputNotifier extends Notifier<Widget> {
  @override
  build() {
    var tokenizerSource = ref.watch(debounceTextProvider);
    final tokenizerInstance = Tokenizer(tokenizerSource);
    var parserInput = tokenizerInstance.tokenize();
    final parserInstance = Parser(parserInput);
    var rendererInput = parserInstance.parseProgram();
    final rendererInstance = Renderer(rendererInput);
    return rendererInstance.render();
  }
}
