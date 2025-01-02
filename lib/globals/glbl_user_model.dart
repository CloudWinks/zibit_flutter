import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  // Fields corresponding to the SQL table columns
  int _userId;
  String _email;
  String? _passwordHash;
  String? _firstName;
  String? _lastName;
  String? _username;
  String? _phoneNumber;
  DateTime? _dateOfBirth;
  String? _gender;
  String? _country;
  String? _languagePreference;
  String? _themePreference;
  String? _notificationPreferences;
  String? _googleID;
  String? _facebookID;
  DateTime? _createdAt;
  DateTime? _lastLogin;
  bool _isActive;
  bool _isLocked;
  DateTime? _lastPasswordChange;

  // Constructor
  UserModel({
    required int userId,
    required String email,
    String? passwordHash,
    String? firstName,
    String? lastName,
    String? username,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? country,
    String? languagePreference,
    String? themePreference,
    String? notificationPreferences,
    String? googleID,
    String? facebookID,
    DateTime? createdAt,
    DateTime? lastLogin,
    bool isActive = true,
    bool isLocked = false,
    DateTime? lastPasswordChange,
  })  : _userId = userId,
        _email = email,
        _passwordHash = passwordHash,
        _firstName = firstName,
        _lastName = lastName,
        _username = username,
        _phoneNumber = phoneNumber,
        _dateOfBirth = dateOfBirth,
        _gender = gender,
        _country = country,
        _languagePreference = languagePreference,
        _themePreference = themePreference,
        _notificationPreferences = notificationPreferences,
        _googleID = googleID,
        _facebookID = facebookID,
        _createdAt = createdAt,
        _lastLogin = lastLogin,
        _isActive = isActive,
        _isLocked = isLocked,
        _lastPasswordChange = lastPasswordChange;

  // Getters
  int get userId => _userId;
  String get email => _email;
  String? get passwordHash => _passwordHash;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get username => _username;
  String? get phoneNumber => _phoneNumber;
  DateTime? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get country => _country;
  String? get languagePreference => _languagePreference;
  String? get themePreference => _themePreference;
  String? get notificationPreferences => _notificationPreferences;
  String? get googleID => _googleID;
  String? get facebookID => _facebookID;
  DateTime? get createdAt => _createdAt;
  DateTime? get lastLogin => _lastLogin;
  bool get isActive => _isActive;
  bool get isLocked => _isLocked;
  DateTime? get lastPasswordChange => _lastPasswordChange;

  // Setters with notifyListeners for state changes
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set passwordHash(String? value) {
    _passwordHash = value;
    notifyListeners();
  }

  set firstName(String? value) {
    _firstName = value;
    notifyListeners();
  }

  set lastName(String? value) {
    _lastName = value;
    notifyListeners();
  }

  set username(String? value) {
    _username = value;
    notifyListeners();
  }

  set phoneNumber(String? value) {
    _phoneNumber = value;
    notifyListeners();
  }

  set dateOfBirth(DateTime? value) {
    _dateOfBirth = value;
    notifyListeners();
  }

  set gender(String? value) {
    _gender = value;
    notifyListeners();
  }

  set country(String? value) {
    _country = value;
    notifyListeners();
  }

  set languagePreference(String? value) {
    _languagePreference = value;
    notifyListeners();
  }

  set themePreference(String? value) {
    _themePreference = value;
    notifyListeners();
  }

  set notificationPreferences(String? value) {
    _notificationPreferences = value;
    notifyListeners();
  }

  set googleID(String? value) {
    _googleID = value;
    notifyListeners();
  }

  set facebookID(String? value) {
    _facebookID = value;
    notifyListeners();
  }

  set createdAt(DateTime? value) {
    _createdAt = value;
    notifyListeners();
  }

  set lastLogin(DateTime? value) {
    _lastLogin = value;
    notifyListeners();
  }

  set isActive(bool value) {
    _isActive = value;
    notifyListeners();
  }

  set isLocked(bool value) {
    _isLocked = value;
    notifyListeners();
  }

  set lastPasswordChange(DateTime? value) {
    _lastPasswordChange = value;
    notifyListeners();
  }

void updateUserData({
  required int userId,
  required String email,
  String? firstName,
  String? lastName,
  String? username,
  String? phoneNumber,
  DateTime? dateOfBirth,
  String? gender,
  String? country,
  String? languagePreference,
  String? themePreference,
  String? notificationPreferences,
  String? googleID,
  String? facebookID,
  DateTime? lastLogin,
}) {
  _userId = userId;
  _email = email;
  _firstName = firstName;
  _lastName = lastName;
  _username = username;
  _phoneNumber = phoneNumber;
  _dateOfBirth = dateOfBirth;
  _gender = gender;
  _country = country;
  _languagePreference = languagePreference;
  _themePreference = themePreference;
  _notificationPreferences = notificationPreferences;
  _googleID = googleID;
  _facebookID = facebookID;
  _lastLogin = lastLogin;
  notifyListeners();
}





  // Factory method to create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['UserID'] ?? 0,
      email: json['Email'] ?? '',
      passwordHash: json['PasswordHash'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      username: json['Username'],
      phoneNumber: json['PhoneNumber'],
      dateOfBirth: json['DateOfBirth'] != null ? DateTime.parse(json['DateOfBirth']) : null,
      gender: json['Gender'],
      country: json['Country'],
      languagePreference: json['LanguagePreference'],
      themePreference: json['ThemePreference'],
      notificationPreferences: json['NotificationPreferences'],
      googleID: json['GoogleID'],
      facebookID: json['FacebookID'],
      createdAt: json['CreatedAt'] != null ? DateTime.parse(json['CreatedAt']) : null,
      lastLogin: json['LastLogin'] != null ? DateTime.parse(json['LastLogin']) : null,
      isActive: json['IsActive'] ?? true,
      isLocked: json['IsLocked'] ?? false,
      lastPasswordChange: json['LastPasswordChange'] != null ? DateTime.parse(json['LastPasswordChange']) : null,
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'UserID': _userId,
      'Email': _email,
      'PasswordHash': _passwordHash,
      'FirstName': _firstName,
      'LastName': _lastName,
      'Username': _username,
      'PhoneNumber': _phoneNumber,
      'DateOfBirth': _dateOfBirth?.toIso8601String(),
      'Gender': _gender,
      'Country': _country,
      'LanguagePreference': _languagePreference,
      'ThemePreference': _themePreference,
      'NotificationPreferences': _notificationPreferences,
      'GoogleID': _googleID,
      'FacebookID': _facebookID,
      'CreatedAt': _createdAt?.toIso8601String(),
      'LastLogin': _lastLogin?.toIso8601String(),
      'IsActive': _isActive,
      'IsLocked': _isLocked,
      'LastPasswordChange': _lastPasswordChange?.toIso8601String(),
    };
  }
}