import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olive_app/app/app.dart';
import 'package:olive_app/data/local/auth_local_datasource.dart';
import 'package:olive_app/data/models/auth_state.dart';
import 'package:olive_app/ui/views/auth_view.dart';
import 'package:olive_app/ui/views/stores_picker_view.dart';
import 'package:olive_app/core/services/supabase_service.dart';
import 'package:olive_app/view_models/auth_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

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
  late final AuthViewModel _authViewModel;

  @override
  void initState() {
    super.initState();
    // Initialize AuthViewModel to set up auth state listener
    _authViewModel = AuthViewModel();

    // Handle deep links for OAuth callback
    supabase.Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (data.event == supabase.AuthChangeEvent.signedIn) {
        // The AuthViewModel will handle saving the state
        // This just ensures we're listening
      }
    });
  }

  @override
  void dispose() {
    _authViewModel.dispose();
    super.dispose();
  }

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

            // No merchant means not logged in
            if (authState?.merchant == null) {
              return const AuthView();
            }

            // Merchant exists but no selected store
            if (authState?.selectedStore == null) {
              return const StoresPickerView();
            }

            return const MainApp();
          },
        ),
      ),
    );
  }
}
