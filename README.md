<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Expression Parser and Evaluator

## Overview

This package provides a simple expression parser and evaluator for mathematical expressions. It supports basic arithmetic, trigonometric functions, logarithmic functions, constants (`π` and `e`), and percentages. The core functionality is achieved through tokenization and evaluation of mathematical expressions.

The parser converts an input string (expression) into tokens, while the evaluator interprets the tokens to compute the result.

### Features

- **Arithmetic Operations**: Supports `+`, `-`, `*`, `/`.
- **Trigonometric Functions**: `sin`, `cos`, `tan`.
- **Logarithmic Functions**: `log` (base 10), `ln` (natural logarithm).
- **Mathematical Functions**: `sqrt` (square root), `exp` (exponential), `abs` (absolute value).
- **Constants**: `π` (Pi), `e` (Euler’s number).
- **Percentages**: Handles percentages (`%`), automatically dividing by 100.
- **Parentheses**: Supports grouped expressions with `()`.

## Example Usage

Here’s an example of how to use the package to evaluate an expression:

```dart
void main() {
  final expression = "50% * 100 + sin(π / 2)";
  final parser = ExpressionParser(expression);
  final tokens = parser.tokenize();
  final evaluator = ExpressionEvaluator(tokens);
  final result = evaluator.evaluate();

  print(result); // Output: 50.0
}
```

### Input Expression

The input expression can contain:

- **Numbers**: Any valid number (e.g., `123`, `3.14`, `0.001`).
- **Operators**: `+`, `-`, `*`, `/`.
- **Functions**: `sin()`, `cos()`, `tan()`, `log()`, `ln()`, `sqrt()`, `exp()`, `abs()`.
- **Constants**: `π`, `e`.
- **Percentages**: Denoted by the `%` symbol (e.g., `50%` is automatically interpreted as `0.50`).
- **Grouping**: Expressions can be grouped with parentheses `( ... )`.

### Features Breakdown

1. **Tokenization**:
   - The expression is converted into a list of tokens where each token represents a number, operator, function, or constant.
2. **Evaluation**:
   - The evaluator processes the token list and computes the result based on the order of operations.

## Classes and Methods

### 1. `Token`

Represents a single unit in the expression.

- `type`: The type of the token (`number`, `operator`, `leftParen`, `rightParen`, `function`, `constant`).
- `lexeme`: The actual string representation of the token (e.g., `"+", "50", "sin"`).

### 2. `ExpressionParser`

Responsible for tokenizing the expression string into a list of `Token` objects.

#### Methods:

- `tokenize()`: Converts the input expression into a list of tokens.
- `_preprocessExpression(String expression)`: Preprocesses the expression by handling special cases, like leading decimals.
- `_parseNumber(String expression)`: Extracts and returns a number token from the expression.
- `_parseIdentifier(String expression)`: Extracts and returns an identifier (such as a function or constant) from the expression.

### 3. `ExpressionEvaluator`

Interprets and evaluates the list of tokens to compute the final result.

#### Methods:

- `evaluate()`: Evaluates the entire tokenized expression and returns the result as a `double`.
- `_expression()`: Evaluates expressions involving addition or subtraction.
- `_term()`: Evaluates terms involving multiplication or division.
- `_factor()`: Evaluates factors like numbers, constants, and functions (including percentages).
- `log10(double value)`: Helper method to calculate the base-10 logarithm.

### Error Handling

If an invalid token or expression is encountered during evaluation, an error is thrown and printed. For example, if there is an unexpected token type or a missing closing parenthesis, an exception is raised to indicate the issue.

### Supported Operators and Functions

#### Operators:

- `+`: Addition
- `-`: Subtraction
- `*`: Multiplication
- `/`: Division
- `%`: Percentage (implicitly divides the preceding number by 100)

#### Trigonometric Functions:

- `sin(x)`: Sine
- `cos(x)`: Cosine
- `tan(x)`: Tangent

#### Logarithmic Functions:

- `log(x)`: Logarithm base 10
- `ln(x)`: Natural logarithm (base `e`)

#### Mathematical Functions:

- `sqrt(x)`: Square root
- `exp(x)`: Exponential function
- `abs(x)`: Absolute value

#### Constants:

- `π`: Pi (`3.14159...`)
- `e`: Euler’s number (`2.71828...`)

## Installation

To install the package, include it in your `pubspec.yaml` file:

```yaml
dependencies:
  expression_parser: ^1.0.0
```

## Conclusion

This package is a flexible tool for parsing and evaluating mathematical expressions. It supports a wide variety of operations, including percentages, trigonometric and logarithmic functions, constants, and basic arithmetic. It’s useful for scenarios where you need to evaluate user input or perform dynamic calculations in a Flutter/Dart application.
