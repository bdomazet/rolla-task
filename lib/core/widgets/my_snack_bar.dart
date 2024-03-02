import 'package:flutter/material.dart';

void displaySnackBar(
  BuildContext context, {
  required String? message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.grey.shade100,
      content: Text(
        message ?? 'Some error has occurred',
        style: const TextStyle(color: Colors.grey),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
