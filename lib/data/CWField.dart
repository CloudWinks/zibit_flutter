class Field {
  int fieldid;
  int seq;
  String? id;
  String? label;
  int? dbType;
  int? inputType;
  bool? visible;
  bool? enabled;
  int? alignment;
  String? defaultimage;
  String? defaulttextfield;

  Field({
    required this.fieldid,
    required this.seq,
    this.id,
    this.label,
    this.dbType,
    this.inputType,
    this.visible,
    this.enabled,
    this.alignment,
    this.defaultimage,
    this.defaulttextfield,
  });

  // Factory constructor to create from JSON
  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      fieldid: json['fieldid'] ?? 0,
      seq: json['seq'] ?? 0,
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
