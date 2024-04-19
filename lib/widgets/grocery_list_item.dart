import 'package:flutter/material.dart';
import 'package:shopping/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({super.key, required this.grocery});

  final GroceryItem grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(grocery.name),
      leading: Container(
        width: 24,
        height: 24,
        color: grocery.category.color,
      ),
      trailing: Text('${grocery.quantity}'),
    );
  }
}
