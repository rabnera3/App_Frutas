import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/Notification.dart';

class NotificationProvider extends ChangeNotifier {
  late Box<NotificationItem> _notificationsBox;

  NotificationProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _notificationsBox =
        await Hive.openBox<NotificationItem>('notificationsBox');
    notifyListeners();
  }

  List<NotificationItem> get notifications => _notificationsBox.values.toList();

  void addNotification(NotificationItem notification) {
    _notificationsBox.add(notification);
    notifyListeners();
  }

  void removeNotification(NotificationItem notification) {
    final key = _notificationsBox.keys
        .firstWhere((k) => _notificationsBox.get(k) == notification);
    _notificationsBox.delete(key);
    notifyListeners();
  }

  void clearNotifications() {
    _notificationsBox.clear();
    notifyListeners();
  }

  int get notificationCount => _notificationsBox.length;
}
