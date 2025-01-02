class Parameter {
  final int paramid;
  final int seq;
  final int? type; // Optional field
  final String? value; // Optional field

  Parameter({
    required this.paramid,
    required this.seq,
    this.type, // Optional field
    this.value, // Optional field
  });

  // Factory constructor to create from JSON
  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      paramid: json['paramid'] ?? 0, // Default to 0 if null or missing
      seq: json['seq'] ?? 0, // Default to 0 if null or missing
      type: json['type'], // Allow null
      value: json['value'], // Allow null
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'paramid': paramid,
      'seq': seq,
      'type': type,
      'value': value,
    };
  }
}
