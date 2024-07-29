class Favorite {
  final int id;
  final int userId;
  final String productId;

  Favorite({
    required this.id,
    required this.userId,
    required this.productId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
    };
  }
}
