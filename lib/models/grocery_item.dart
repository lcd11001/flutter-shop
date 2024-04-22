import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopping/data/categories.dart';
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

  static GroceryItem fromJson(Map<String, dynamic> value, String key) {
    final category = categories.values.firstWhere(
      (element) => element.name == value['category'],
      orElse: () => Category(value['category'], Colors.black),
    );

    return GroceryItem.withId(
      id: key,
      name: value['name'],
      quantity: value['quantity'],
      category: category,
    );
  }
}
