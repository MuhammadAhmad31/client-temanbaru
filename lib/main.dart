import 'package:flutter/material.dart';
import 'app.dart';
import 'di/di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
