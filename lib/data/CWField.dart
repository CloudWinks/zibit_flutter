class Field {
  int fieldid;
  int seq;
  String id;
  String label;
  int dbType;
  int inputType;
  bool visible;
  bool enabled;
  int alignment;
  String defaultimage;
  String defaulttextfield;

  Field({
    required this.fieldid,
    required this.seq,
    required this.id,
    required this.label,
    required this.dbType,
    required this.inputType,
    required this.visible,
    required this.enabled,
    required this.alignment,
    required this.defaultimage,
    required this.defaulttextfield,
  });

  // Factory constructor to create from JSON
  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      fieldid: json['fieldid'],
      seq: json['seq'],
      id: json['id'],
      label: json['label'],
      dbType: json['dbType'],
      inputType: json['inputType'],
      visible: json['visible'],
      enabled: json['enabled'],
      alignment: json['alignment'],
      defaultimage: json['defaultimage'] ?? '',
      defaulttextfield: json['defaulttextfield'] ?? '',
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'fieldid': fieldid,
      'seq': seq,
      'id': id,
      'label': label,
      'dbType': dbType,
      'inputType': inputType,
      'visible': visible,
      'enabled': enabled,
      'alignment': alignment,
      'defaultimage': defaultimage,
      'defaulttextfield': defaulttextfield,
    };
  }
}