import 'package:flutter/material.dart';

class TonalOption extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isActive;

  const TonalOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isActive = false,
  });

  @override
  State<TonalOption> createState() => _TonalOptionState();
}

class _TonalOptionState extends State<TonalOption> {
  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final baseColor = widget.isActive
        ? colors.primaryContainer
        : colors.surfaceVariant.withOpacity(0.6);
    final textColor = widget.isActive
        ? colors.onPrimaryContainer
        : colors.onSurfaceVariant;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: _pressed
            ? baseColor.withOpacity(0.85)
            : baseColor, // darker when pressed
        borderRadius: BorderRadius.circular(14),
        boxShadow: _pressed
            ? [
                BoxShadow(
                  color: colors.primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onHighlightChanged: _setPressed,
          onTap: widget.onTap,
          splashColor: colors.primary.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 18, color: textColor),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
