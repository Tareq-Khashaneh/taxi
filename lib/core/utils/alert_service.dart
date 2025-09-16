// lib/core/utils/alert_service.dart
import 'package:flutter/material.dart';

abstract class AlertsService {
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  static Future<void> showCustomDialog(BuildContext context, Widget dialogContent) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: dialogContent,
      ),
    );
  }

  static void showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (_) => child,
    );
  }
}
