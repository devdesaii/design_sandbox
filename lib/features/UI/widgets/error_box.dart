import 'package:flutter/material.dart';
import 'package:design_sandbox/features/UI/theme_constants.dart';

class ErrorBox extends StatelessWidget {
  final String message;
  const ErrorBox(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: errorBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: errorBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: errorText, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: errorText, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
