import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/profile_cubit.dart';

/// Date-of-birth field driven entirely by ProfileCubit state — the display
/// string is formatted in the state layer, never here (Zero UI Logic).
class EditDateField extends StatelessWidget {
  const EditDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, (String, bool)>(
      selector: (state) => (state.dateDisplay, state.hasDate),
      builder: (context, data) {
        final (display, hasDate) = data;
        return GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: context.colors.mutedCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colors.softBorder),
            ),
            child: Row(
              children: [
                Icon(Icons.cake, color: context.colors.textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.dateOfBirth.tr(),
                        style: AppTextStyles.labelSurface.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        display,
                        style: hasDate
                            ? AppTextStyles.bodySurface.copyWith(
                                color: context.colors.textPrimary,
                              )
                            : AppTextStyles.bodyMutedSurface.copyWith(
                                color: context.colors.textSecondary,
                              ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.colors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();
    final picked = await showDatePicker(
      context: context,
      initialDate: cubit.state.dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) cubit.selectDate(picked);
  }
}
