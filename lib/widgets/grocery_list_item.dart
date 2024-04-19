import 'package:flutter/material.dart';
import 'package:shopping/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  final void Function(GroceryItem) onDismissed;

  const GroceryListItem({
    super.key,
    required this.grocery,
    required this.onDismissed,
  });

  final GroceryItem grocery;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(grocery.id),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDismissed(grocery);
        }
      },
      direction: DismissDirection.endToStart,
      child: ListTile(
        title: Text(grocery.name),
        leading: Container(
          width: 24,
          height: 24,
          color: grocery.category.color,
        ),
        trailing: Text('${grocery.quantity}'),
      ),
    );
  }
}
