import 'package:flutter/cupertino.dart';

class Food {
  final String name;
  final double price;
  final String image;
  final String description;
  final String id;
  final String category;

  Food(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.description,
      this.category});
}
