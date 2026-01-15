import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olive_app/app/app.dart';
import 'package:olive_app/data/local/auth_local_datasource.dart';
import 'package:olive_app/data/models/auth_state.dart';
import 'package:olive_app/ui/views/auth_view.dart';
import 'package:olive_app/core/services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _authDataSource = AuthLocalDataSource();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoCondensed', useMaterial3: true),
      home: SafeArea(
        child: StreamBuilder<AuthState?>(
          stream: _authDataSource.watchAuthState(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }

            final authState = snapshot.data;
            if (authState?.merchant == null ||
                authState?.selectedStore == null) {
              return const AuthView();
            }

            return const MainApp();
          },
        ),
      ),
    );
  }
}
