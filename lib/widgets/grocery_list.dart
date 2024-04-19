import 'package:flutter/material.dart';
import 'package:shopping/models/grocery_item.dart';
import 'package:shopping/widgets/grocery_list_item.dart';

class GroceryList extends StatelessWidget {
  final List<GroceryItem> groceries;

  const GroceryList({super.key, required this.groceries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceries.length,
      itemBuilder: (context, index) {
        return GroceryListItem(grocery: groceries[index]);
      },
    );
  }
}
