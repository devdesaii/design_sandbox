abstract class ASTNode {}

class WidgetNode extends ASTNode {
  String name;
  Map<String, ASTNode>? properties;
  WidgetNode(this.name, {this.properties});
  void getValue() {
    print(this.name);
  }
}

class LiteralNode extends ASTNode {
  final Object value;
  LiteralNode(this.value);
  void getValue() {
    print(this.value);
  }
}
