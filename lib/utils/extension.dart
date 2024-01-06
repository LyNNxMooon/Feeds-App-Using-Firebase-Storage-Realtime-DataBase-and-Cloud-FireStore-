import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateBack({Object? data}) {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop(data);
    }
  }
}
