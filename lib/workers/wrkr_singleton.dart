class AppSingleton {
  // Private constructor
  AppSingleton._privateConstructor();
  static final AppSingleton _instance = AppSingleton._privateConstructor();

  // Factory to return the same instance
  factory AppSingleton() => _instance;

  // Private variables
  int? _userId;
  String? _name;
  String? _email;

  // Getter for userId
  int? get userId => _userId;

  // Setter for userId with validation
  set userId(int? value) {
    if (value != null && value < 0) {
      throw Exception('User ID cannot be negative.');
    }
    _userId = value;
  }

  // Getter for name
  String? get name => _name;

  // Setter for name with formatting
  set name(String? value) {
    _name = value?.trim();
  }

  // Getter for email
  String? get email => _email;

  // Setter for email with validation
  set email(String? value) {
    if (value != null && !value.contains('@')) {
      throw Exception('Invalid email address.');
    }
    _email = value;
  }

  // Method to reset all variables
  void reset() {
    _userId = null;
    _name = null;
    _email = null;
    print('AppSingleton reset.');
  }
}
