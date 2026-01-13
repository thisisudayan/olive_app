import 'package:flutter/material.dart';

class ProgressState extends StatelessWidget {
  const ProgressState({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.black,
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
    );
  }
}