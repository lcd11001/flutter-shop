import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping/api/api.dart';
import 'package:shopping/data/dummy_items.dart';
import 'package:shopping/models/grocery_item.dart';

class GroceryItemProvider extends StateNotifier<AsyncValue<List<GroceryItem>>> {
  GroceryItemProvider() : super(const AsyncLoading()) {
    _init();
  }

  Future<void> _init() async {
    state = await AsyncValue.guard(() => API.fetchGroceryItems());
  }

  Future<void> add(GroceryItem item) async {
    // use copyWithPrevious to keep the previous state while loading
    state = const AsyncLoading<List<GroceryItem>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final items = state.value ?? [];
      final newItem = await API.addGroceryItem(item);
      if (newItem != null) {
        return [...items, newItem];
      }
      return items;
    });
  }

  Future<void> remove(GroceryItem item) async {
    final items = state.value ?? [];
    final remainItems =
        items.where((element) => element.id != item.id).toList();

    // fix dissmissed item not removed from the list
    state = const AsyncLoading<List<GroceryItem>>()
        .copyWithPrevious(AsyncValue.data(remainItems));

    state = await AsyncValue.guard(() async {
      final success = await API.removeGroceryItem(item.id);
      if (success) {
        return remainItems;
      }
      return items;
    });
  }
}

final groceryItemProvider = StateNotifierProvider.autoDispose<
    GroceryItemProvider, AsyncValue<List<GroceryItem>>>(
  (ref) => GroceryItemProvider(),
);
