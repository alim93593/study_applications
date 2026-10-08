import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/schedule_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_add_button.dart';
import '../cubit/schedule_cubit.dart';
import '../cubit/schedule_state.dart';

/// عنوان الشاشة + التاريخ (من الـ Cubit) + زر الإضافة في أول الشاشة.
class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScheduleCubit, ScheduleState, String>(
      selector: (s) => s.dateLabel,
      builder: (context, dateLabel) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ScheduleStrings.scheduleTitle.tr(),
                    style: AppTextStyles.displayMedium.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(dateLabel, style: AppTextStyles.bodyMutedSurface),
                  const SizedBox(height: 4),
                  Text(
                    ScheduleStrings.scheduleSubtitle.tr(),
                    style: AppTextStyles.bodyMutedSurface,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            AppAddButton(onPressed: () => AppNavigator.push(AppRouter.newTask)),
          ],
        );
      },
    );
  }
}
