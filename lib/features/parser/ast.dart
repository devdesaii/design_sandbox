abstract class ASTNode {}

class WidgetNode extends ASTNode {
  String name;
  Map<String, ASTNode>? properties;

  WidgetNode(this.name, {this.properties});
}

class LiteralNode extends ASTNode {
  final Object value;
  LiteralNode(this.value);
}
