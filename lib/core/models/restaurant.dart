import 'package:flutter_foodybite/core/models/food.dart';

class Restaurant {
  final String name;
  final String image;
  final List<Food> foods;

  Restaurant({this.name, this.image, this.foods});
}
