class ActClass {
  // Class-level fields
  late List<DbsField> dataFields; // Holds the list of data fields
  String? constants; // Placeholder-containing string for replacement

  ActClass() {
    dataFields = <DbsField>[]; // Initialize data fields list
  }

  // Add a new data field to the list
  void addDbsField(DbsField field) {
    dataFields.add(field);
  }

  // Set the constants string
  void setConstants(String string) {
    constants = string;
  }

  // Replace placeholders in the constants string with field values
  void setup() {
    if (constants == null) return;

    for (int sim = 0; sim < 10; sim++) {
      final search = '#$sim';
      if (constants!.contains(search)) {
        final replace = dataFields.length > sim
            ? dataFields[sim].value.toString()
            : '';
        constants = constants!.replaceAll(search, replace);
      }
    }
  }

  // Placeholder for further action
  void doAction() {
    // Implement action-specific logic here
  }
}

// Represents a single data field
class DbsField {
  dynamic value;

  DbsField({this.value});

  dynamic getValue() => value;

  void setValue(dynamic newValue) {
    value = newValue;
  }
}
