import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.title,
    required this.description,
    this.onRetry,
  });

  final String title;
  final String description;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/network_error.png", width: 160, height: 160),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF363C44),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 40,
          child: OutlinedButton(
            style: FilledButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0xFF363C44),
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: onRetry,
            child: const Text(
              "TRY AGAIN",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Color(0xFF363C44),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
