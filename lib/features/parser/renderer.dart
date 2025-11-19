import 'package:flutter/material.dart';
import 'package:design_sandbox/features/parser/parser.dart';
import 'package:design_sandbox/features/parser/ast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      }
    }
    return Colors.blue;
  }

  Widget buildWidget(WidgetNode node) {
    switch (node.name) {
      case 'Container':
        return Container(
          color:
              node.properties != null && node.properties!.containsKey('color')
              ? extractColor(node.properties!['color']!)
              : Colors.transparent,
          width:
              node.properties != null && node.properties!.containsKey('width')
              ? buildDouble(node.properties!['width']!)
              : null,
          height:
              node.properties != null && node.properties!.containsKey('height')
              ? buildDouble(node.properties!['height']!)
              : null,
          padding:
              node.properties != null && node.properties!.containsKey('padding')
              ? EdgeInsets.all(buildDouble(node.properties!['padding']!) ?? 0.0)
              : null,
          child:
              node.properties != null && node.properties!.containsKey('child')
              ? astNodeToWidget(node.properties!['child']!)
              : null,
        );
      case 'Text':
        final text = node.properties?['value'];
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
