import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Footer row: prefix text + tappable action (login ↔ register switch).
class AuthLinkRow extends StatelessWidget {
  const AuthLinkRow({
    super.key,
    required this.prefixKey,
    required this.actionKey,
    required this.onTap,
  });

  final String prefixKey;
  final String actionKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefixKey.tr(), style: AppTextStyles.bodyMuted),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(actionKey.tr(), style: AppTextStyles.bodyStrong),
        ),
      ],
    );
  }
}
