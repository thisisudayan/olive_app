import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:olive_app/view_models/auth_view_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthViewModel _viewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          body: Stack(
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
                          text:
                              'INVENTORY • ORDER • PAYMENT • SHIPMENT • CUSTOMER TRACKING • INVOICE • MARKETING • '
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
                          text:
                              'PREMIUM TEMPLATE • SOCIAL MEDIA LOGIN • SEO READY • UNLIMITED STORAGE • '
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
                          text:
                              'ANALYTICS • COLLABORATION • OLIVER AI AGENT • MULTI STORE • '
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
                  padding: const EdgeInsets.only(
                    bottom: 26,
                    left: 12,
                    right: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_viewModel.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: CircularProgressIndicator(),
                        ),
                      if (_viewModel.error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            _viewModel.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _viewModel.isLoading
                                ? null
                                : _viewModel.signInWithGoogle,
                            icon: Image.asset(
                              "assets/google.png",
                              width: 24,
                              height: 24,
                            ),
                            label: const Text("Sign in with google"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shadowColor: Colors.transparent,
                            ),
                          ),
                          IconButton.filledTonal(
                            onPressed: _viewModel.isLoading
                                ? null
                                : _viewModel.signInWithGithub,
                            icon: Image.asset(
                              "assets/github.png",
                              width: 24,
                              height: 24,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shadowColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
