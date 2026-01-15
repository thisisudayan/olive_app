import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olive_app/app/app.dart';
import 'package:olive_app/ui/views/auth_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(const Application());
}


class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoCondensed', useMaterial3: true),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: const AuthView(),
        ),
      ),
    );
  }
}