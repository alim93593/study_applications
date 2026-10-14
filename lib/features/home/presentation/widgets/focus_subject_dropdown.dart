import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/subject_label.dart';

/// قائمة اختيار مادة الجلسة — أسماء المستخدم تُعرض كما هي (لا تحذيرات).
class FocusSubjectDropdown extends StatelessWidget {
  const FocusSubjectDropdown({
    super.key,
    required this.options,
    required this.value,
    required this.enabled,
    required this.hint,
    required this.onChanged,
  });

  final List<String> options;
  final String value;
  final bool enabled;
  final String hint;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: options.contains(value) ? value : null,
        isExpanded: true,
        dropdownColor: context.colors.card,
        iconEnabledColor: context.colors.textSecondary,
        hint: Text(
          hint,
          style: AppTextStyles.bodyMutedSurface.copyWith(fontSize: 14),
        ),
        items: [
          for (final option in options)
            DropdownMenuItem(
              value: option,
              child: Text(
                option.subjectLabel,
                style: AppTextStyles.bodyStrong.copyWith(
                  fontSize: 14,
                  color: context.colors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
