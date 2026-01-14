import 'package:flutter/material.dart';
import 'package:olive_app/ui/widgets/oliver_badge.dart';
import 'package:olive_app/ui/widgets/squircle_image_group.dart';

class OliveListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String>? imageUrls;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? badgeText;
  final String? noteText;

  const OliveListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrls,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.badgeText,
    this.noteText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: SquircleImageGroup(
        imageUrls: imageUrls,
        fallbackImageUrl: "assets/default_avatar.png",
        defaultImageUrl: "assets/default_avatar.png",
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          OliverBadge(badgeText: badgeText),
        ],
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          if (noteText != null) ...[
            const SizedBox(width: 12),
            Text(
              noteText!,
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
          ],
        ],
      ),
      trailing: trailing,
    );
  }
}
