import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/Notification.dart';
import '../models/User.dart';

class NotificationProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<NotificationItem> _notifications = [];
  User? _user;
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  NotificationProvider() {
    _initNotifications();
  }

  void setUser(User? user) {
    _user = user;
    _loadNotifications();
  }

  Future<void> _initNotifications() async {
    await _dbHelper.database;
    await _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    if (_user == null) return;

    final results = await _dbHelper.rawQuery(
      'SELECT * FROM notifications WHERE user_id = ?',
      [_user!.id],
    );

    _notifications = results.map((result) {
      return NotificationItem.fromJson(result);
    }).toList();
    notifyListeners();
  }

  List<NotificationItem> get notifications => _notifications;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;

  void setNotificationSettings({
    required bool notificationsEnabled,
    required bool soundEnabled,
    required bool vibrationEnabled,
  }) {
    _notificationsEnabled = notificationsEnabled;
    _soundEnabled = soundEnabled;
    _vibrationEnabled = vibrationEnabled;
    notifyListeners();
  }

  Future<void> addNotification(NotificationItem notification) async {
    if (_user == null || !_notificationsEnabled) return;

    await _dbHelper.insert('notifications', {
      'user_id': _user!.id,
      'title': notification.title,
      'message': notification.message,
      'date_time': notification.dateTime.toIso8601String(),
    });
    _notifications.add(notification);
    notifyListeners();

    // Reproducir sonido
    if (_soundEnabled) {
      FlutterRingtonePlayer.playNotification();
    }

    // Activar vibración
    if (_vibrationEnabled && (await Vibration.hasVibrator() ?? false)) {
      Vibration.vibrate();
    }
  }

  Future<void> removeNotification(NotificationItem notification) async {
    if (_user == null) return;

    await _dbHelper.delete(
      'notifications',
      'id = ? AND user_id = ?',
      [notification.id, _user!.id],
    );
    _notifications.removeWhere((item) => item.id == notification.id);
    notifyListeners();
  }

  Future<void> clearNotifications() async {
    if (_user == null) return;

    await _dbHelper.delete(
      'notifications',
      'user_id = ?',
      [_user!.id],
    );
    _notifications.clear();
    notifyListeners();
  }

  int get notificationCount => _notifications.length;
}
