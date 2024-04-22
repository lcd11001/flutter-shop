import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping/api/api.dart';
import 'package:shopping/data/dummy_items.dart';
import 'package:shopping/models/grocery_item.dart';

class GroceryItemProvider extends StateNotifier<List<GroceryItem>> {
  GroceryItemProvider() : super(groceryItems);

  void add(GroceryItem item) async {
    final (success, id) = await API.addGroceryItem(item);
    debugPrint("Success: $success, ID: $id");
    if (success) {
      state = [...state, item.clone(id)];
    }
  }

  void remove(GroceryItem item) {
    state = state.where((element) => element.id != item.id).toList();
  }
}

final groceryItemProvider =
    StateNotifierProvider<GroceryItemProvider, List<GroceryItem>>((ref) {
  return GroceryItemProvider();
});
