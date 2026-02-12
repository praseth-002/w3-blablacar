import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback? onPressed;
  final BlaButtonType type;

  const BlaButton({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.type = BlaButtonType.primary,
  });

  bool get _isPrimary => type == BlaButtonType.primary;
  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDisabled
              ? BlaColors.disabled
              : _isPrimary
              ? BlaColors.primary
              : Colors.white,
          foregroundColor: isDisabled
              ? BlaColors.textLight
              : _isPrimary
              ? Colors.white
              : BlaColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
            side: _isPrimary || isDisabled
                ? BorderSide.none
                : BorderSide(color: BlaColors.primary),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(text, style: BlaTextStyles.button),
          ],
        ),
      ),
    );
  }
}
