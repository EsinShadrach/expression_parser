extension NumExtension on num {
  String toWords() {
    return numToWord(toInt());
  }

  String addCommas() {
    String numberString = toString();

    List<String> parts = numberString.split(".");

    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : "";

    final integerBuffer = StringBuffer();
    int length = integerPart.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        integerBuffer.write(",");
      }
      integerBuffer.write(integerPart[i]);
    }

    if (decimalPart.isNotEmpty) {
      return "${integerBuffer.toString()}.$decimalPart";
    }
    return integerBuffer.toString();
  }
}

String numToWord(int num) {
  const units = [
    "Zero",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Twelve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen"
  ];

  const tens = <String>[
    "Zero",
    "Ten",
    "Twenty",
    "Thirty",
    "Forty",
    "Fifty",
    "Sixty",
    "Seventy",
    "Eighty",
    "Ninety"
  ];

  if (num < 20) {
    return units[num.toInt()];
  }

  if (num < 100) {
    return tens[(num ~/ 10)] + (num % 10 != 0 ? " ${units[num % 10]}" : "");
  }

  if (num < 1000) {
    return '${units[(num ~/ 100)]} Hundred${num % 100 != 0 ? ' and ${numToWord(num % 100)}' : ''}';
  }

  if (num < 1000000) {
    return '${numToWord(num ~/ 1000)} Thousand${num % 1000 != 0 ? ' ${numToWord(num % 1000)}' : ''}';
  }

  if (num < 1000000000) {
    return '${numToWord(num ~/ 1000000)} Million${num % 1000000 != 0 ? ' ${numToWord(num % 1000000)}' : ''}';
  }

  if (num < 1000000000000) {
    return '${numToWord(num ~/ 1000000000)} Billion${num % 1000000000 != 0 ? " ${numToWord(num % 1000000000)}" : ""}';
  }

  return '${numToWord(num ~/ 1000000000000)} Trillion${num % 1000000000000 != 0 ? " ${numToWord(num % 1000000000000)}" : ""}';
}
