import 'package:expression_parser/expression_parser.dart';

void main() {
  final expression = "50% * 100 + sin(π / 2)";
  final parser = ExpressionParser(expression);
  final tokens = parser.tokenize();
  final evaluator = ExpressionEvaluator(tokens);
  final result = evaluator.evaluate();

  print(result); // Output: 50.0
}
