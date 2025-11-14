import 'package:design_sandbox/features/sandbox/providers/style_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomPreview extends ConsumerWidget {
  const BottomPreview({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: (ref.watch(styleProvider).shadowEnabled
            ? [
                BoxShadow(
                  color: ref
                      .watch(styleProvider)
                      .shadowColor
                      .withOpacity(ref.watch(styleProvider).shadowOpacity),
                  blurRadius: ref.watch(styleProvider).shadowBlur,
                  offset: Offset(
                    ref.watch(styleProvider).shadowOffsetX,
                    ref.watch(styleProvider).shadowOffsetY,
                  ),
                ),
              ]
            : []),
        color: ref.watch(styleProvider).backgroundColor,
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.all(
          Radius.circular(ref.watch(styleProvider).borderRadius),
        ),
      ),
      child: Center(child: Card(child: Text("[Preview Card]"))),
    );
  }
}
