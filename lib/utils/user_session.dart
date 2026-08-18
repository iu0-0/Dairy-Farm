import 'package:flutter/material.dart';

enum UserRole { admin, user }

class UserSession extends ChangeNotifier {
  static final UserSession _instance = UserSession._internal();
  factory UserSession() => _instance;
  UserSession._internal();

  UserRole _role = UserRole.admin; // Default to Admin mode for testing

  UserRole get role => _role;
  bool get isAdmin => _role == UserRole.admin;
  bool get isUser => _role == UserRole.user;

  String get roleName => isAdmin ? 'Farm Administrator' : 'Standard User';

  void setRole(UserRole newRole) {
    if (_role != newRole) {
      _role = newRole;
      notifyListeners();
    }
  }

  void toggleRole() {
    _role = _role == UserRole.admin ? UserRole.user : UserRole.admin;
    notifyListeners();
  }
}

final globalUserSession = UserSession();
