import "dart:math" as math;

import "package:expression_parser/expression_parser.dart";
import "package:test/test.dart";

void main() {
  group("Test Out ExpressionParser", () {
    test("Test Out Basic Arithmetics", () {
      String expression = "2 + 2";

      final parser = ExpressionParser(expression);

      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      expect(result.toString(), "4.0");
    });

    // Test out Pi
    test("Test Out PI", () {
      String expression = "π";

      final parser = ExpressionParser(expression);

      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      expect(result.toString(), math.pi.toString());
    });

    // TEST COSINE

    test("TEST FOR COSINE", () {
      String expression = "cos(60)";

      final parser = ExpressionParser(expression);
      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      // expect(result.toString(), "1.0");
      expect(
        result.toString(),
        math.cos(60).toString(),
      );
    });

    test("Test for multiplication", () {
      String expression = "2*2";

      final parser = ExpressionParser(expression);
      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      expect(
        result.toString(),
        "4.0",
      );
    });

    test("More Complex Multiplication", () {
      String expression = "2*2*2";

      final parser = ExpressionParser(expression);
      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      expect(
        result.toString(),
        (2 * 2 * 2).toDouble().toString(),
      );
    });
  });

  group("Test Out to Word", () {
    test("Test Out Basic Arithmetics", () {
      String expression = "2 + 2";

      final parser = ExpressionParser(expression);
      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      expect(result.toString(), "4.0");

      final word = numToWord(result.toInt());

      print("Word => $word");

      expect(word.toLowerCase(), "four");
    });

    test("Larger Expression (multiplication)", () {
      String expression = "2*2*2";

      final parser = ExpressionParser(expression);
      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      expect(
        result.toString(),
        (2 * 2 * 2).toDouble().toString(),
      );

      final word = numToWord(result.toInt());

      print("Word => $word");

      expect(word.toLowerCase(), "eight");
    });

    test("Even Larger Expression (multiplication)", () {
      // 6*2*2*8*40*400

      String expression = "6*2*2*8*40*400";

      final parser = ExpressionParser(expression);
      final tokens = parser.tokenize();
      final evaluator = ExpressionEvaluator(tokens);
      final result = evaluator.evaluate();

      print("Result => $result");

      expect(
        result.toString(),
        (6 * 2 * 2 * 8 * 40 * 400).toDouble().toString(),
      );
      // Evaluestaes to 3,072,000

      final word = numToWord(result.toInt());

      print("Word => $word");

      expect(word.toLowerCase(), "three million seventy two thousand");
    });
  });
}
