class ObjAction {
  final String className;
  final List<String> dataFields;
  final String constants;

  ObjAction(String className, String dataFields, String constants)
      : className = className,
        dataFields = dataFields.split(','),
        constants = constants;

  String getClassName() {
    return className;
  }

  List<String> getDataFields() {
    return dataFields;
  }

  String getConstants() {
    return constants;
  }
}
