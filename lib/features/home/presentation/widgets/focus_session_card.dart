import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/focus_session_cubit.dart';
import '../cubit/focus_session_state.dart';
import 'focus_subject_dropdown.dart';

/// بطاقة جلسة التركيز: اختيار مادة + مؤقت start/stop يحفظ جلسة حقيقية.
class FocusSessionCard extends StatelessWidget {
  const FocusSessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      FocusSessionCubit,
      FocusSessionState,
      ({bool running, String elapsed, String subject, List<String> options})
    >(
      selector: (s) => (
        running: s.running,
        elapsed: s.elapsedDisplay,
        subject: s.subject,
        options: s.subjectOptions,
      ),
      builder: (context, data) {
        final cubit = context.read<FocusSessionCubit>();
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.colors.softBorder),
            boxShadow: const [
              BoxShadow(color: AppColors.softShadow, blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            children: [
              Icon(
                data.running ? Icons.timer : Icons.timer_outlined,
                color: AppColors.primary,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: data.running
                    ? Text(
                        data.elapsed,
                        style: AppTextStyles.titleLarge.copyWith(
                          color: context.colors.textPrimary,
                        ),
                      )
                    : FocusSubjectDropdown(
                        options: data.options,
                        value: data.subject,
                        enabled: true,
                        hint: StatsStrings.focusSessionTitle.tr(),
                        onChanged: (value) {
                          if (value != null) cubit.onSubjectSelected(value);
                        },
                      ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: data.running
                      ? AppColors.error
                      : AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: data.running ? cubit.stop : cubit.start,
                child: Text(
                  data.running
                      ? StatsStrings.focusStop.tr()
                      : StatsStrings.focusStart.tr(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
