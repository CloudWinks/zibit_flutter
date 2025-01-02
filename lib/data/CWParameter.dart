class Parameter {
  int paramid;
  int seq;
  int type;
  String value;

  Parameter({
    required this.paramid,
    required this.seq,
    required this.type,
    required this.value,
  });

  // Factory constructor to create from JSON
  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      paramid: json['paramid'],
      seq: json['seq'],
      type: json['type'],
      value: json['value'] ?? '',
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