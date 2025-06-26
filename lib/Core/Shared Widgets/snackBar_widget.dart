import 'package:flutter/material.dart';

extension ErrorSnackbar on BuildContext {
  void showErrorSnackBar(String message, {Color color = Colors.red}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()   // optional: hide any existing one
      ..showSnackBar(snackBar);
  }
}
