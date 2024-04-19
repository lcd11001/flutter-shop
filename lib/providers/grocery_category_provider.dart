import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/categories.dart';

final groceryCategoryProvider = Provider((ref) => categories);
