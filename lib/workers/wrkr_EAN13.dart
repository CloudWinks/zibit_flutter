class EAN13CodeBuilder {
  final String codeStringValue;
  late String generatedCode;

  EAN13CodeBuilder(this.codeStringValue) {
    parse();
  }

  String getCode() {
    return generatedCode;
  }

  /// Generates the full EAN-13 code with the control number
  String _getFullCode() {
    int chetVal = 0;
    int nechetVal = 0;

    for (int index = 0; index < 6; index++) {
      chetVal += int.parse(codeStringValue[index * 2 + 1]);
      nechetVal += int.parse(codeStringValue[index * 2]);
    }

    chetVal *= 3;
    int controlNumber = 10 - (chetVal + nechetVal) % 10;
    if (controlNumber == 10) controlNumber = 0;

    return '$codeStringValue$controlNumber';
  }

  /// Converts a digit to an uppercase letter
  String _digitToUpperCase(String digit) {
    const String letters = "ABCDEFGHIJ";
    int position = int.parse(digit);
    return letters[position];
  }

  /// Converts a digit to a lowercase letter
  String _digitToLowerCase(String digit) {
    const String letters = "abcdefghij";
    int position = int.parse(digit);
    return letters[position];
  }

  /// Generates the EAN-13 encoded string
  String _createEAN13Code(String rawCode) {
    int firstFlag = int.parse(rawCode[0]);
    String leftString = rawCode.substring(1, 7);
    String rightString = rawCode.substring(7);

    String rightCode = '';
    for (int i = 0; i < 6; i++) {
      rightCode += _digitToLowerCase(rightString[i]);
    }

    String leftCode;
    switch (firstFlag) {
      case 0:
        leftCode = "#!$leftString";
        break;
      case 1:
        leftCode =
            "\$!${leftString[0]}${leftString[1]}${_digitToUpperCase(leftString[2])}${leftString[3]}${_digitToUpperCase(leftString[4])}${_digitToUpperCase(leftString[5])}";
        break;
      case 2:
        leftCode =
            "%!${leftString[0]}${leftString[1]}${_digitToUpperCase(leftString[2])}${_digitToUpperCase(leftString[3])}${leftString[4]}${_digitToUpperCase(leftString[5])}";
        break;
      case 3:
        leftCode =
            "&!${leftString[0]}${leftString[1]}${_digitToUpperCase(leftString[2])}${_digitToUpperCase(leftString[3])}${_digitToUpperCase(leftString[4])}${leftString[5]}";
        break;
      case 4:
        leftCode =
            "'!${leftString[0]}${_digitToUpperCase(leftString[1])}${leftString[2]}${leftString[3]}${_digitToUpperCase(leftString[4])}${_digitToUpperCase(leftString[5])}";
        break;
      case 5:
        leftCode =
            "(!${leftString[0]}${_digitToUpperCase(leftString[1])}${_digitToUpperCase(leftString[2])}${leftString[3]}${leftString[4]}${_digitToUpperCase(leftString[5])}";
        break;
      case 6:
        leftCode =
            ")!${leftString[0]}${_digitToUpperCase(leftString[1])}${_digitToUpperCase(leftString[2])}${_digitToUpperCase(leftString[3])}${leftString[4]}${leftString[5]}";
        break;
      case 7:
        leftCode =
            "*!${leftString[0]}${_digitToUpperCase(leftString[1])}${leftString[2]}${_digitToUpperCase(leftString[3])}${leftString[4]}${_digitToUpperCase(leftString[5])}";
        break;
      case 8:
        leftCode =
            "+!${leftString[0]}${_digitToUpperCase(leftString[1])}${leftString[2]}${_digitToUpperCase(leftString[3])}${_digitToUpperCase(leftString[4])}${leftString[5]}";
        break;
      case 9:
        leftCode =
            ",!${leftString[0]}${_digitToUpperCase(leftString[1])}${_digitToUpperCase(leftString[2])}${leftString[3]}${_digitToUpperCase(leftString[4])}${leftString[5]}";
        break;
      default:
        throw Exception('Invalid first digit in EAN-13 code');
    }

    return '$leftCode-$rightCode!';
  }

  /// Parses the EAN-13 code
  void parse() {
    String fullCode = _getFullCode();
    print('Full code: $fullCode');
    generatedCode = _createEAN13Code(fullCode);
    print('Generated code: $generatedCode');
  }
}
