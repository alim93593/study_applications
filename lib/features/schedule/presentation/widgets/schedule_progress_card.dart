import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/schedule_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/schedule_cubit.dart';
import '../cubit/schedule_state.dart';

/// بطاقة نسب الإنجاز العامة (CURRENT PROGRESS) — القيم من الـ Cubit.
class ScheduleProgressCard extends StatelessWidget {
  const ScheduleProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScheduleCubit, ScheduleState, (String, double)>(
      selector: (s) => (s.progressDisplay, s.progressValue),
      builder: (context, values) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.mutedCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ScheduleStrings.currentProgress.tr(),
                      style: AppTextStyles.labelMedium.copyWith(
                        color: context.colors.textSecondary,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      values.$1,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      ScheduleStrings.progressComplete.tr(),
                      style: AppTextStyles.bodyMutedSurface,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 56,
                height: 56,
                child: CircularProgressIndicator(
                  value: values.$2,
                  strokeWidth: 6,
                  backgroundColor: context.colors.softBorder,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
