
String normalizeInput(String raw) {
  if (raw.isEmpty) return raw;

  var src = raw.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

  src = src.replaceAll('\t', '  ');

  final buffer = StringBuffer();
  final lines = src.split('\n');

  bool previousWasBlank = false;

  for (var i = 0; i < lines.length; i++) {
    var line = lines[i];

    line = line.replaceFirst(RegExp(r'\s+$'), '');

    final isBlank = line.trim().isEmpty;

    if (isBlank) {
      if (previousWasBlank) {
        continue;
      } else {
        previousWasBlank = true;
        buffer.writeln();
        continue;
      }
    } else {
      previousWasBlank = false;
      buffer.writeln(line);
    }
  }

  final normalized = buffer.toString().trim();

  return normalized;
}
