class DblRecord {
  // Map to store key-value pairs
  Map<String, dynamic> values = {};

  // Getters for various data types
  dynamic getObject(String key) => values[key];

  bool? getBoolean(String key) => values[key] is bool ? values[key] : null;

  int? getByte(String key) => values[key] is int ? values[key] : null;

  List<int>? getAsByteArray(String key) => values[key] is List<int> ? values[key] : null;

  double? getAsDouble(String key) => values[key] is double ? values[key] : null;

  double? getAsFloat(String key) => values[key] is double ? values[key] : null;

  int? getAsInteger(String key) => values[key] is int ? values[key] : null;

  int? getAsLong(String key) => values[key] is int ? values[key] : null;

  int? getAsShort(String key) => values[key] is int ? values[key] : null;

  String? getAsString(String key) => values[key]?.toString();

  // Setter for values
  void setValues(Map<String, dynamic> newValues) {
    values = newValues;
  }

  // To set a specific value
  void setValue(String key, dynamic value) {
    values[key] = value;
  }

  // To get the current values as a Map
  Map<String, dynamic> getValues() => values;

  // To get an ID (assumes the value is stored as an integer or can be cast)
  int? getId(String key) => values[key] is int ? values[key] : null;

  // String representation for debugging or logging
  @override
  String toString() {
    return values.toString();
  }
}
