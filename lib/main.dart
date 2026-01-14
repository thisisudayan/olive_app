import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olive_app/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(const MainApp());
}
