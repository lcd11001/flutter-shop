import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/providers/grocery_item_provider.dart';

import 'package:shopping/screens/grocery_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Hide both the status bar and the navigation bar
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groceryItemProvider);

    return MaterialApp(
      home: Stack(
        children: [
          const GroceryScreen(),
          if (state.isLoading)
            const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
