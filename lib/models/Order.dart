class Order {
  final int? id;
  final int userId;
  final DateTime date;
  final double total;
  final String status;

  Order({
    this.id,
    required this.userId,
    required this.date,
    required this.total,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      date: DateTime.parse(json['date']),
      total: json['total'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'total': total,
      'status': status,
    };
  }

  Order copyWith({
    int? id,
    int? userId,
    DateTime? date,
    double? total,
    String? status,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }
}
