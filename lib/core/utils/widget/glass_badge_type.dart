import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

enum GlassBadgeType { success, error, warning, info }

extension GlassBadgeTypeColors on GlassBadgeType {
  /// لون النوع الأساسي — دالة واحدة بدل تكرار نفس الـ switch أربع مرات
  /// داخل الودجت (كان مكررًا في _getBorderColor/_getTextColor/_getDotColor).
  Color get color {
    switch (this) {
      case GlassBadgeType.success:
        return AppColors.success;
      case GlassBadgeType.error:
        return AppColors.error;
      case GlassBadgeType.warning:
        return AppColors.warning;
      case GlassBadgeType.info:
        return AppColors.info;
    }
  }

  /// خلفية شفافة بنفس لون النوع (alpha 0.2).
  Color get background => color.withValues(alpha: 0.2);
}
