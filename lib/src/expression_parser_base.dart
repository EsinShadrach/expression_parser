import "dart:math" as math;

enum TokenType {
  number,
  operator,
  leftParen,
  rightParen,
  function,
  constant,
}

class Token {
  final TokenType type;
  final String lexeme;

  Token(this.type, this.lexeme);

  @override
  String toString() {
    return "Token { $type, $lexeme }";
  }
}

class ExpressionParser {
  final String expression;
  int currentPosition = 0;

  ExpressionParser(this.expression);

  List<Token> tokenize() {
    String processedExpression = _preprocessExpression(expression);
    List<Token> tokens = [];

    while (currentPosition < processedExpression.length) {
      final char = processedExpression[currentPosition];

      if (RegExp(r"[0-9]").hasMatch(char)) {
        final number = _parseNumber(processedExpression);
        tokens.add(Token(TokenType.number, number));

        if (currentPosition < processedExpression.length &&
            processedExpression[currentPosition] == "%") {
          tokens.add(Token(TokenType.operator, "%"));
          currentPosition++;
        }
      } else if (char == "+" || char == "-" || char == "*" || char == "/") {
        tokens.add(Token(TokenType.operator, char));
        currentPosition++;
      } else if (char == "(") {
        tokens.add(Token(TokenType.leftParen, char));
        currentPosition++;
      } else if (char == ")") {
        tokens.add(Token(TokenType.rightParen, char));
        currentPosition++;
      } else if (char == "|" &&
          tokens.isNotEmpty &&
          tokens.last.type == TokenType.number) {
        tokens.add(Token(TokenType.function, "abs"));
        currentPosition++;
      } else if (RegExp(r"[a-zA-Zπ]").hasMatch(char)) {
        final identifier = _parseIdentifier(processedExpression);

        if (identifier == "sin" ||
            identifier == "cos" ||
            identifier == "tan" ||
            identifier == "log" ||
            identifier == "ln" ||
            identifier == "sqrt" ||
            identifier == "exp" ||
            identifier == "abs") {
          tokens.add(Token(TokenType.function, identifier));
        } else if (identifier == "π" || identifier == "e") {
          tokens.add(Token(TokenType.constant, identifier));
        }
      } else {
        currentPosition++;
      }
    }

    return tokens;
  }

  String _preprocessExpression(String expression) {
    // Replace '.number' with '0.number'
    return expression.replaceAllMapped(
      RegExp(r"(?<!\d)\.(\d)"),
      (match) => "0.${match.group(1)}",
    );
  }

  String _parseIdentifier(String expression) {
    final start = currentPosition;

    while (currentPosition < expression.length &&
        RegExp(r"[a-zA-Zπ]").hasMatch(expression[currentPosition])) {
      currentPosition++;
    }
    return expression.substring(start, currentPosition);
  }

  String _parseNumber(String expression) {
    final start = currentPosition;
    while (currentPosition < expression.length &&
        RegExp(r"[0-9.]").hasMatch(expression[currentPosition])) {
      currentPosition++;
    }
    return expression.substring(start, currentPosition);
  }
}

class ExpressionEvaluator {
  final List<Token> tokens;
  int currentToken = 0;

  ExpressionEvaluator(this.tokens);

  double evaluate() {
    try {
      return _expression();
    } catch (e) {
      print("Evaluation error: $e");
      return double.nan;
    }
  }

  double _expression() {
    var result = _term();
    while (match(TokenType.operator, "+") || match(TokenType.operator, "-")) {
      final operator = tokens[currentToken++];
      final right = _term();
      if (operator.lexeme == "+") {
        result += right;
      } else {
        result -= right;
      }
    }
    return result;
  }

  double _term() {
    var result = _factor();
    while (match(TokenType.operator, "*") || match(TokenType.operator, "/")) {
      final operator = tokens[currentToken++];
      final right = _factor();
      if (operator.lexeme == "*") {
        result *= right;
      } else {
        result /= right;
      }
    }
    return result;
  }

  double _factor() {
    if (match(TokenType.number)) {
      double value = double.parse(tokens[currentToken++].lexeme);

      if (match(TokenType.operator, "%")) {
        currentToken++;
        value = value / 100.0;
      }

      return value;
    } else if (match(TokenType.constant)) {
      final constant = tokens[currentToken++].lexeme;

      if (constant == "π") {
        return math.pi;
      } else if (constant == "e") {
        return math.e;
      }
    } else if (match(TokenType.function)) {
      final function = tokens[currentToken++].lexeme;
      expect(TokenType.leftParen);
      final argument = _expression();
      expect(TokenType.rightParen);

      switch (function) {
        case "sin":
          return math.sin(argument);
        case "cos":
          return math.cos(argument);
        case "tan":
          return math.tan(argument);
        case "log":
          return log10(argument);
        case "ln":
          return math.log(argument);
        case "sqrt":
          return math.sqrt(argument);
        case "exp":
          return math.exp(argument);
        case "abs":
          return argument.abs();
        default:
          throw Exception("Unknown function: $function");
      }
    } else if (match(TokenType.leftParen)) {
      currentToken++;
      final value = _expression();
      expect(TokenType.rightParen);
      return value;
    } else {
      throw Exception("Unexpected token: ${tokens[currentToken].lexeme}");
    }

    throw Exception("Unexpected token in factor evaluation");
  }

  bool match(TokenType type, [String? lexeme]) {
    if (currentToken >= tokens.length) return false;
    final token = tokens[currentToken];
    if (token.type == type && (lexeme == null || token.lexeme == lexeme)) {
      return true;
    }
    return false;
  }

  void expect(TokenType type, [String? lexeme]) {
    if (!match(type, lexeme)) {
      throw Exception(
          "Expected token ${type.toString()} with lexeme '$lexeme' but found ${tokens[currentToken].type.toString()} with lexeme '${tokens[currentToken].lexeme}'");
    }
    currentToken++;
  }

  double log10(double value) {
    return math.log(value) / math.ln10;
  }
}
