import 'package:flutter/material.dart';

class AppLocaleProvider extends ChangeNotifier {
  String languageCode = 'en';

  void setLanguageCode(String code) {
    if (code == languageCode) {
      return;
    }
    languageCode = code;
    notifyListeners();
  }
}
