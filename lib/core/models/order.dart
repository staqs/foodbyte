import 'package:flutter/cupertino.dart';

class Order {
  final String id;
  final double price;
  final String foodId;
  final String userId;
  final int quantity;
  final String resId;
  Order(
      {@required this.resId,
      this.quantity,
      this.id,
      this.price,
      @required this.foodId,
      @required this.userId});
}
