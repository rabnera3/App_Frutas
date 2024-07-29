import 'package:flutter/foundation.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/Notification.dart';

class NotificationProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<NotificationItem> _notifications = [];

  NotificationProvider() {
    _init();
  }

  Future<void> _init() async {
    await _dbHelper.database;
    await _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final results = await _dbHelper.query('notifications');
    _notifications = results.map((result) {
      return NotificationItem.fromJson(result);
    }).toList();
    notifyListeners();
  }

  List<NotificationItem> get notifications => _notifications;

  Future<void> addNotification(NotificationItem notification) async {
    await _dbHelper.execute(
      'INSERT INTO notifications (title, message, date_time) VALUES (?, ?, ?)',
      [
        notification.title,
        notification.message,
        notification.dateTime.toIso8601String(),
      ],
    );
    // Obtener el ID del último insertado
    var result = await _dbHelper
        .rawQuery('SELECT id FROM notifications ORDER BY id DESC LIMIT 1');
    var insertId = result.first['id'];

    _notifications.add(NotificationItem(
      id: insertId,
      title: notification.title,
      message: notification.message,
      dateTime: notification.dateTime,
    ));
    notifyListeners();
  }

  Future<void> removeNotification(NotificationItem notification) async {
    await _dbHelper.execute(
      'DELETE FROM notifications WHERE id = ?',
      [notification.id],
    );
    _notifications.removeWhere((n) => n.id == notification.id);
    notifyListeners();
  }

  Future<void> clearNotifications() async {
    await _dbHelper.execute('DELETE FROM notifications');
    _notifications.clear();
    notifyListeners();
  }

  int get notificationCount => _notifications.length;
}
