import 'package:flutter/foundation.dart';
import '../models/Notification.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications => _notifications;

  void addNotification(NotificationItem notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void removeNotification(NotificationItem notification) {
    _notifications.remove(notification);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }

  int get notificationCount =>
      _notifications.length; // Contador de notificaciones
}
