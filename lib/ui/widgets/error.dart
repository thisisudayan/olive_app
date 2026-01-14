import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.title,
    this.description,
    this.onRetry,
    this.retryText = "TRY AGAIN",
    this.maxWidth = 220,
  });

  final String? title;
  final String? description;
  final VoidCallback? onRetry;
  final String retryText;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Image.asset("assets/network_error.png", width: 160, height: 160),
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF363C44),
              ),
            ),
          if (description != null)
            SizedBox(
              width: maxWidth,
              child: Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
          if (onRetry != null)
            Container(
              padding: const EdgeInsets.all(4),
              child: OutlinedButton(
                style: FilledButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF363C44), width: 4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: onRetry,
                child: Text(
                  retryText,
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
      ),
    );
  }
}
