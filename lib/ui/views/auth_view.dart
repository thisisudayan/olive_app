import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:olive_app/core/services/supabase_service.dart';
import 'package:olive_app/data/local/auth_local_datasource.dart';
import 'package:olive_app/data/models/auth_state.dart' as local;
import 'package:olive_app/data/models/merchant_model.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _authDataSource = AuthLocalDataSource();

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    SupabaseService().client.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        // Fetch merchant data (using metadata as placeholder or strict DB query)
        final user = session.user;
        final merchant = MerchantModel(
          id: user.id,
          email: user.email ?? '',
          name: user.userMetadata?['name'],
          avatar: user.userMetadata?['avatar_url'],
        );

        // Fetch stores (mock or API call).
        final defaultStore = StoreModel(
          id: 1,
          name: "My First Store",
          role: RoleModel(id: 1, name: "Owner"),
          status: "active",
          lastUpdate: DateTime.now(),
        );

        final authState = local.AuthState(
          merchant: merchant,
          selectedStore: defaultStore,
          allStores: [defaultStore],
        );

        await _authDataSource.saveAuthState(authState);
      }
    });
  }

  Future<void> _handleGoogleLogin() async {
    await SupabaseService().auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'appcommerz://login-callback',
    );
  }

  Future<void> _handleGithubLogin() async {
    await SupabaseService().auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: 'appcommerz://login-callback',
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        /// Background carousel
        CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 1,
            autoPlay: true,
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return SizedBox.expand(
              child: Image.asset(
                "assets/banner_image_1.png",
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),

        /// Angled marquee banner
        Positioned(
          top: height * 0.6, // 60% from top
          left: -20, // little overflow for angle
          right: -20,
          child: Transform.rotate(
            angle: -3 * math.pi / 180, // slight tilt (-3°)
            child: Column(
              children: [
                Container(
                  height: 60,
                  color: Colors.amber,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Marquee(
                    text: 'Mega deals • Fast delivery • Trusted sellers • '
                        .toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                    ),
                    velocity: 70,
                    blankSpace: 4,
                  ),
                ),
                Container(
                  height: 60,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Marquee(
                    text: 'Mega deals • Fast delivery • Trusted sellers • '
                        .toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                    ),
                    velocity: 70,
                    textDirection: TextDirection.rtl,
                    blankSpace: 4,
                  ),
                ),
                Container(
                  height: 60,
                  color: Colors.amber,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Marquee(
                    text: 'Mega deals • Fast delivery • Trusted sellers • '
                        .toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                    ),
                    velocity: 70,
                    blankSpace: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 26, left: 12, right: 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _handleGoogleLogin,
                  icon: Image.asset("assets/google.png", width: 24, height: 24),
                  label: const Text("Sign in with google"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shadowColor: Colors.transparent,
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: _handleGithubLogin,
                  icon: Image.asset("assets/github.png", width: 24, height: 24),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
