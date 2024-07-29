import 'package:hive/hive.dart';

part 'Notification.g.dart';

@HiveType(typeId: 1)
class NotificationItem extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String message;

  @HiveField(2)
  late DateTime dateTime;

  NotificationItem({
    required this.title,
    required this.message,
    required this.dateTime,
  });
}
