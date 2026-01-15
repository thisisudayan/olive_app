import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
              return Container(
                width: double.infinity,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: Text('Slide $i', style: const TextStyle(fontSize: 22)),
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
          Positioned(
            bottom: 26,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/google.png",
                        width: 24,
                        height: 24,
                      ),
                      label: Text("Sign in with google"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/github.png",
                        width: 24,
                        height: 24,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
