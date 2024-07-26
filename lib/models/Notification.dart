import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String message;
  final void Function(BuildContext context) onTap;

  NotificationItem({
    required this.title,
    required this.message,
    required this.onTap,
  });
}
