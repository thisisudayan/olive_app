// while state changes, show widget with animated chages
// enum input [loading, offline, online, error, upToDate]
// show different icons for different state and change with animation.

import 'package:flutter/material.dart';
import 'package:olive_app/core/services/connectivity_service.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum NetworkState { loading, error, upToDate }

class NetworkExposer extends StatelessWidget {
  const NetworkExposer({super.key, required this.state, this.onTap});

  final NetworkState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ConnectivityService().onConnectivityChanged,
      initialData: ConnectivityService().isOnline,
      builder: (context, snapshot) {
        final bool isOnline = snapshot.data ?? true;

        // Map state to corresponding icon
        Widget currentIcon;
        if (!isOnline) {
          currentIcon = Icon(
            LucideIcons.wifiOff,
            key: const ValueKey('offline'),
            size: 20,
            color: Colors.red,
          );
        } else {
          switch (state) {
            case NetworkState.loading:
              currentIcon = const SpinningIcon(key: ValueKey('loading'));
              break;
            case NetworkState.error:
              currentIcon = Icon(
                LucideIcons.info,
                key: ValueKey('error'),
                size: 20,
                color: Colors.orange,
              );
              break;
            case NetworkState.upToDate:
              currentIcon = const Icon(
                LucideIcons.cloud,
                key: ValueKey('upToDate'),
                size: 20,
                color: Colors.blue,
              );
              break;
          }
        }

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: SizedBox(
                  key: ValueKey(isOnline ? state : 'offline'),
                  width: 28,
                  height: 28,
                  child: Center(child: currentIcon),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SpinningIcon extends StatefulWidget {
  const SpinningIcon({super.key});

  @override
  State<SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<SpinningIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // speed of rotation
    )..repeat(); // continuously spins
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(
        LucideIcons.loaderCircle,
        key: ValueKey('loading'),
        size: 24,
        color: Colors.blue,
      ),
    );
  }
}
