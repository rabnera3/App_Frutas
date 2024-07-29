class CartItem {
  final int id;
  final int userId;
  final String productId;
  final int quantity;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
