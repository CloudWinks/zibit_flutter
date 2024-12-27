import 'dart:convert';

class DbsField {
  String name;
  int dbType;
  dynamic value;

  DbsField({
    required this.name,
    required this.dbType,
    this.value,
  });

  String get getName => name;

  set setName(String name) {
    this.name = name;
  }

  int get getDbType => dbType;

  set setDbType(int dbType) {
    this.dbType = dbType;
  }

  dynamic get getValue {
    if (value == null) {
      // Set default values based on dbType
      if (dbType == Constants.DBTYPE_FLOAT ||
          dbType == Constants.DBTYPE_INTEGER) {
        value = 0;
      } else {
        value = "";
      }
    }
    return value;
  }

  set setValue(dynamic value) {
    this.value = value;
  }

  void setValueNull() {
    value = null;
  }

  /// Convert the field to a JSON string
  String getDbFieldJson() {
    return jsonEncode({
      'name': getName,
      'type': getDbType,
      'value': getValue,
    });
  }

  /// Convert the field to a JSON object
  Map<String, dynamic> getDbFieldJsonObject() {
    return {
      'name': getName,
      'type': getDbType,
      'value': getValue,
    };
  }
}

class Constants {
  static const int DBTYPE_FLOAT = 1;
  static const int DBTYPE_INTEGER = 2;
  static const int DBTYPE_STRING = 3;
  // Add more constants as required
}
