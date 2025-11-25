import 'package:flutter/material.dart';
import 'package:design_sandbox/features/compiler/ast.dart';

class Renderer {
  Renderer(this.nodeTree);
  final ASTNode nodeTree;

  Widget render() {
    return astNodeToWidget(nodeTree);
  }

  Object? buildLiteral(ASTNode node) {
    if (node is LiteralNode) {
      return node.value;
    }
    throw Exception('Expected a LiteralNode');
  }

  double? buildDouble(ASTNode? node) {
    if (node == null) return null;
    final val = buildLiteral(node);
    if (val is double) return val;
    if (val is int) return val.toDouble();
    if (val is String) {
      return double.tryParse(val);
    }
    return null;
  }

  Color extractColor(ASTNode node) {
    if (node is LiteralNode && node.value is String) {
      final colorString = node.value as String;
      switch (colorString.toLowerCase()) {
        case 'red':
          return Colors.red;
        case 'green':
          return Colors.green;
        case 'blue':
          return Colors.blue;
        case 'black':
          return Colors.black;
      }
    }
    if (node is WidgetNode) {
      final colorString = node.name;
      switch (colorString.toLowerCase()) {
        case 'red':
          return Colors.red;
        case 'green':
          return Colors.green;
        case 'blue':
          return Colors.blue;
        case 'black':
          return Colors.black;
      }
    }
    return Colors.blue;
  }

  Widget buildWidget(WidgetNode node) {
    final props = node.properties;
    switch (node.name) {
      case 'Container':
        if (props == null) {
          return Container();
        }

        const allowedKeys = {'color', 'width', 'height', 'padding', 'child'};

        final unknownKeys = props.keys
            .where((k) => !allowedKeys.contains(k))
            .toList();
        if (unknownKeys.isNotEmpty) {
          throw Exception(
            'Unknown property "${unknownKeys.first}" for Container',
          );
        }

        return Container(
          color: props.containsKey('color')
              ? extractColor(props['color']!)
              : Colors.transparent,
          width: props.containsKey('width')
              ? buildDouble(props['width']!)
              : null,
          height: node.properties!.containsKey('height')
              ? buildDouble(props['height']!)
              : null,
          padding:
              node.properties != null && node.properties!.containsKey('padding')
              ? EdgeInsets.all(buildDouble(node.properties!['padding']!) ?? 0.0)
              : null,
          child: props.containsKey('child')
              ? astNodeToWidget(props['child']!)
              : null,
        );
      case 'Text':
        final text = props?['value'];
        final textValue = text != null ? buildLiteral(text) : '';
        return Center(
          child: Text(
            textValue.toString(),
            style: TextStyle(color: Colors.white),
          ),
        );
      default:
        throw Exception('Unknown widget: ${node.name}');
    }
  }

  Widget astNodeToWidget(ASTNode node) {
    if (node is WidgetNode) {
      return buildWidget(node);
    } else {
      throw Exception('Unknown ASTNode type');
    }
  }
}
