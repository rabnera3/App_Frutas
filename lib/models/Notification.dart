class NotificationItem {
  final int? id; // Hacer que el campo id sea opcional
  final String title;
  final String message;
  final DateTime dateTime;

  NotificationItem({
    this.id, // No requerido en el constructor
    required this.title,
    required this.message,
    required this.dateTime,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      dateTime: DateTime.parse(json['date_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'date_time': dateTime.toIso8601String(),
    };
  }
}
