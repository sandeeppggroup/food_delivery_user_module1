import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _showProgress = false;

  bool get showProgress => _showProgress;

  void setProgress(bool value) {
    _showProgress = value;
    notifyListeners();
  }
}
