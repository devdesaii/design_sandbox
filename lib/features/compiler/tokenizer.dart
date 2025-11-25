enum TokenType {
  identifier,
  number,
  string,
  colon,
  comma,
  lbrace,
  rbrace,
  lparen,
  rparen,
  eof,
}

class Token {
  Token({required this.tokenType, required this.col, required this.line});
  TokenType tokenType;
  String? value;
  int line;
  int col;
}

class Tokenizer {
  final String source;
  int line = 1;
  int col = 1;
  int index = 0;

  Tokenizer(this.source);

  bool get isAtend {
    return index >= source.length;
  }

  String get current {
    if (index >= source.length) {
      return "\u0000";
    }
    return source[index];
  }

  void advance() {
    if (!isAtend) {
      if (source[index] == "\n") {
        line++;
        col = 1;
      } else {
        col++;
      }
      index++;
    }
  }

  Token readString() {
    final quote = current;
    final startLine = line;
    final startCol = col;
    bool unterminated = false;

    advance();

    String stringValue = "";
    while (!isAtend) {
      if (current == '\\') {
        advance();
        if (isAtend) {
          unterminated = true;
          break;
        }
        stringValue += current;
        advance();
        continue;
      }

      if (current == quote) {
        advance();
        break;
      }
      stringValue += current;
      advance();
      continue;
    }
    if (unterminated) {
      return Token(tokenType: TokenType.string, col: startCol, line: startLine)
        ..value = "\u0000";
    } else {
      return Token(tokenType: TokenType.string, col: startCol, line: startLine)
        ..value = stringValue;
    }
  }

  List<Token> tokenize() {
    List<Token> tokenizedData = [];
    while (!isAtend) {
      final ch = current;
      if (ch == " " || ch == "\t" || ch == "\n") {
        advance();
        continue;
      }
      if (ch == "_" || RegExp(r'[a-zA-Z]').hasMatch(ch)) {
        final startCol = col;
        final startline = line;
        String identifier = "";
        while (!isAtend &&
            (current == "_" || RegExp(r'[a-zA-Z0-9]').hasMatch(current))) {
          identifier += current;
          advance();
        }
        final token = Token(
          tokenType: TokenType.identifier,
          col: startCol,
          line: startline,
        );
        token.value = identifier;
        tokenizedData.add(token);
        continue;
      }
      if (RegExp(r'[0-9]').hasMatch(ch)) {
        final startcol = col;
        final startline = line;
        String number = "";
        while (!isAtend && (RegExp(r'[0-9.]').hasMatch(current))) {
          if (current == '.' && number.contains('.')) {
            break;
          }
          number += current;
          advance();
        }
        if (!number.endsWith(".")) {
          Token token = Token(
            tokenType: TokenType.number,
            col: startcol,
            line: startline,
          );
          token.value = number;
          tokenizedData.add(token);
          continue;
        }
      }
      if (ch == '"' || ch == "'") {
        tokenizedData.add(readString());
        continue;
      }
      if (ch == "{") {
        Token token = Token(tokenType: TokenType.lbrace, col: col, line: line);
        token.value = ch;
        tokenizedData.add(token);
        advance();
        continue;
      }
      if (ch == "}") {
        Token token = Token(tokenType: TokenType.rbrace, col: col, line: line);
        token.value = ch;
        tokenizedData.add(token);
        advance();
        continue;
      }
      if (ch == "(") {
        Token token = Token(tokenType: TokenType.lparen, col: col, line: line);
        token.value = ch;
        tokenizedData.add(token);
        advance();
        continue;
      }
      if (ch == ")") {
        Token token = Token(tokenType: TokenType.rparen, col: col, line: line);
        token.value = ch;
        tokenizedData.add(token);
        advance();
        continue;
      }
      if (ch == ":") {
        Token token = Token(tokenType: TokenType.colon, col: col, line: line);
        token.value = ch;
        tokenizedData.add(token);
        advance();
        continue;
      }
      if (ch == ",") {
        Token token = Token(tokenType: TokenType.comma, col: col, line: line);
        token.value = ch;
        tokenizedData.add(token);
        advance();
        continue;
      }

      advance();
    }
    tokenizedData.add(Token(tokenType: TokenType.eof, col: col, line: line));
    return tokenizedData;
  }
}
