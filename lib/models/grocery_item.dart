import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:shopping/models/category.dart';

const uuid = Uuid();

class GroceryItem {
  final String id;
  final String name;
  final int quantity;
  final Category category;

  GroceryItem({
    required this.name,
    required this.quantity,
    required this.category,
  }) : id = uuid.v4();

  GroceryItem.withId({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  @override
  String toString() {
    return '$name : $quantity : ${category.name}';
  }

  String toJson() {
    return json.encode({
      'name': name,
      'quantity': quantity,
      'category': category.name,
    });
  }

  GroceryItem clone(String id) {
    return GroceryItem.withId(
      id: id,
      name: name,
      quantity: quantity,
      category: category,
    );
  }
}
