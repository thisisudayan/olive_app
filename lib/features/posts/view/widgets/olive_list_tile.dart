import 'package:flutter/material.dart';

class OliveListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String? badgeText;
  final Color? badgeColor;
  final String? noteText;

  const OliveListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.trailing,
    this.onTap,
    this.badgeText,
    this.badgeColor,
    this.noteText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.zero,
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(color: Colors.transparent),
          ),
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/default_avatar.png",
                      fit: BoxFit.cover,
                      width: 48,
                      height: 48,
                    );
                  },
                )
              : Image.asset(
                  "assets/default_avatar.png",
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          if (badgeText != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: (badgeColor ?? Colors.blue).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (badgeColor ?? Colors.blue).withOpacity(0.2),
                ),
              ),
              child: Text(
                badgeText!,
                style: TextStyle(
                  color: badgeColor ?? Colors.blue,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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