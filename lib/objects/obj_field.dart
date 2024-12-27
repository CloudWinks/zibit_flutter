//import 'dart:convert';

class ObjField {
  String header;
  DbsField dbsField;
  int inputType;
  bool visible;
  bool enabled;
  int alignment;
  String? defaultImage;
  String? defaultTextField;
  String? searchText;

  ObjField({
    required String name,
    required this.header,
    required int dbType,
    required this.inputType,
    required this.visible,
    required this.enabled,
    required this.alignment,
    this.defaultImage,
    this.defaultTextField,
  }) : dbsField = DbsField(name: name, dbType: dbType, value: null);

  Map<String, dynamic> getDbsFieldJson() {
    return dbsField.toJson();
  }

  String getDefaultImage() {
    return defaultImage ?? '';
  }

  void setDefaultImage(String image) {
    defaultImage = image;
  }

  String getDefaultTextField() {
    return defaultTextField ?? '';
  }

  bool isEnabled() {
    return enabled;
  }

  int getAlignment() {
    return alignment;
  }

  int getInputType() {
    return inputType;
  }

  bool isVisible() {
    return visible;
  }

  void setHeader(String header) {
    this.header = header;
  }

  void setInputType(int inputType) {
    this.inputType = inputType;
  }

  void setVisible(bool visible) {
    this.visible = visible;
  }

  void setEnabled(bool enabled) {
    this.enabled = enabled;
  }

  void setSearchText(String searchText) {
    this.searchText = searchText;
  }

  String getSearchText() {
    return searchText ?? '';
  }
}

class DbsField {
  final String name;
  final int dbType;
  dynamic value;

  DbsField({required this.name, required this.dbType, this.value});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': dbType,
      'value': value,
    };
  }
}
