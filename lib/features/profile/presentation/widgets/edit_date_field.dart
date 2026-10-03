import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
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
              color: AppColors.glassWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorder, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.cake, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.dateOfBirth.tr(),
                        style: AppTextStyles.labelGlass,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        display,
                        style: hasDate
                            ? AppTextStyles.bodyLarge
                            : AppTextStyles.bodyGlass,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
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
