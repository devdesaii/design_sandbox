import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResizeableSplit extends ConsumerWidget {
  const ResizeableSplit({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 20,
      decoration: BoxDecoration(border: BoxBorder.all(color: Colors.blue)),
    );
  }
}
