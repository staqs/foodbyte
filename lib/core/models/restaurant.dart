import 'package:flutter_foodybite/core/models/food.dart';

class Restaurant {
  final String name;
  final String image;
  final double latitude;
  final double longitude;
  final String status;
  final String location;
  final List<Food> foods;

  Restaurant(
      {this.status,
      this.latitude,
      this.longitude,
      this.location,
      this.name,
      this.image,
      this.foods});
}
