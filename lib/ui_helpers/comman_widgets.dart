import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommanWidgets {

  /// Stylish SnackBar helper function
  void showCustomSnackBar(
      BuildContext context, {
        required String message,
        bool isError = true, // default red for error
        Duration duration = const Duration(seconds: 3),
      }) {
    final bgColor = isError ? Colors.red.shade700 : Colors.green.shade700;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        duration: duration,
      ),
    );
  }

}