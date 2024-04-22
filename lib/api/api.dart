import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping/models/grocery_item.dart';

class API {
  static const String kBaseUrl =
      "flutter-test-6364b-default-rtdb.asia-southeast1.firebasedatabase.app";

  static Future<(bool, String)> addGroceryItem(GroceryItem item) async {
    try {
      final response = await http.post(
        Uri.https(kBaseUrl, "shopping-list.json"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: item.toJson(),
      );

      debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        String id = body['name'] as String;
        return (true, id);
      }
    } catch (exception) {
      debugPrint("Response Exception: $exception");
    }
    return (false, "");
  }

  static Future<List<GroceryItem>> fetchGroceryItems() async {
    try {
      final response = await http.get(
        Uri.https(kBaseUrl, "shopping-list.json"),
      );

      debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<GroceryItem> items = [];

        body.forEach((key, value) {
          items.add(GroceryItem.fromJson(value, key));
        });

        return items;
      }
    } catch (exception) {
      debugPrint("Response Exception: $exception");
    }
    return [];
  }
}
