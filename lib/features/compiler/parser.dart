import 'package:design_sandbox/features/compiler/ast.dart';
import 'package:design_sandbox/features/compiler/tokenizer.dart';

class Parser {
  Parser(this.tokens);
  List<Token> tokens;
  int index = 0;
  Token get current {
    if (index >= tokens.length) {
      return tokens.last;
    }
    return tokens[index];
  }

  Token? get previous => index > 0 ? tokens[index - 1] : null;

  bool get isAtEnd {
    if (index >= tokens.length) return true;
    return current.tokenType == TokenType.eof;
  }

  Token advance() {
    if (!isAtEnd) {
      index++;
      return tokens[index - 1];
    }
    return tokens.last;
  }

  bool match(TokenType tokenType) {
    if (isAtEnd) return false;
    if (current.tokenType == tokenType) {
      advance();
      return true;
    }
    return false;
  }

  Token expect(TokenType tokenType) {
    if (isAtEnd) {
      throw Exception(
        'ParserError: Expected $tokenType but reached end of input (at ${current.line}:${current.col})',
      );
    }
    if (current.tokenType == tokenType) {
      return advance();
    }
    throw Exception(
      'ParserError: Expected $tokenType but found ${current.tokenType} (at ${current.line}:${current.col})',
    );
  }

  WidgetNode parseWidget() {
    final nameToken = expect(TokenType.identifier);
    final name = nameToken.value ?? '<unknown>';
    final Map<String, ASTNode> props = {};

    if (match(TokenType.lbrace)) {
      props.addAll(parseProperties());
    } else if (match(TokenType.lparen)) {
      if (current.tokenType == TokenType.string ||
          current.tokenType == TokenType.number) {
        final tok = advance();
        props['value'] = LiteralNode(tok.value!);
      } else {
        throw Exception(
          'Expected literal inside parentheses at ${current.line}:${current.col}',
        );
      }
      expect(TokenType.rparen);
    }
    WidgetNode(name, properties: props).getValue();
    return WidgetNode(name, properties: props);
  }

  Map<String, ASTNode> parseProperties() {
    final Map<String, ASTNode> properties = {};

    if (match(TokenType.rbrace)) {
      return properties;
    }

    while (!isAtEnd && current.tokenType != TokenType.rbrace) {
      final keyToken = expect(TokenType.identifier);
      final key = keyToken.value ?? '';
      print(key);

      expect(TokenType.colon);

      final valueNode = parseValue();
      properties[key] = valueNode;

      if (match(TokenType.comma)) {
        continue;
      } else {
        break;
      }
    }

    expect(TokenType.rbrace);
    return properties;
  }

  ASTNode parseValue() {
    if (current.tokenType == TokenType.identifier) {
      return parseWidget();
    }

    if (current.tokenType == TokenType.number ||
        current.tokenType == TokenType.string) {
      return parseLiteral();
    }

    throw Exception(
      'ParserError: Expected value (literal or widget) at ${current.line}:${current.col}, found ${current.tokenType}',
    );
  }

  LiteralNode parseLiteral() {
    if (current.tokenType == TokenType.number) {
      final tok = advance();
      final raw = tok.value ?? '';
      try {
        if ((raw).contains('.')) {
          final d = double.parse(raw);
          LiteralNode(d).getValue();
          return LiteralNode(d);
        } else {
          final i = int.parse(raw);
          LiteralNode(i).getValue();
          return LiteralNode(i);
        }
      } catch (e) {
        throw Exception(
          'ParserError: Invalid number literal "$raw" at ${tok.line}:${tok.col}',
        );
      }
    }
    if (current.tokenType == TokenType.string) {
      final tok = advance();
      final raw = tok.value ?? '';
      if (raw == '\u0000') {
        throw Exception(
          'ParserError: Unterminated string literal starting at ${tok.line}:${tok.col}',
        );
      }
      LiteralNode(raw).getValue();
      return LiteralNode(raw);
    }

    throw Exception(
      'ParserError: parseLiteral called but current is ${current.tokenType} at ${current.line}:${current.col}',
    );
  }

  WidgetNode parseProgram() {
    if (tokens.isEmpty || tokens.last.tokenType != TokenType.eof) {
      tokens.add(
        Token(
          tokenType: TokenType.eof,
          col: tokens.isNotEmpty ? tokens.last.col : 0,
          line: tokens.isNotEmpty ? tokens.last.line : 0,
        ),
      );
    }
    if (isAtEnd) {
      throw Exception('ParserError: Empty input');
    }

    final root = parseWidget();

    if (current.tokenType != TokenType.eof) {
      throw Exception(
        'ParserError: Unexpected token ${current.tokenType} at ${current.line}:${current.col} after parsing complete widget',
      );
    }
    root.getValue();
    return root;
  }
}
