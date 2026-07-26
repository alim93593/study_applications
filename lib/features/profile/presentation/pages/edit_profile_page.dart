import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../../../../core/utils/widget/glass_app_bar.dart';
import '../../../../core/utils/widget/glass_button.dart';
import '../../../../core/utils/widget/glass_text_form_field.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class EditProfilePage extends HookWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedDate = useState<DateTime?>(null);

    useEffect(() {
      final state = context.read<AuthCubit>().state;
      final user = state.user;
      if (state.status == AuthStatus.authenticated &&
          user != null &&
          nameController.text.isEmpty) {
        nameController.text = user.name;
        phoneController.text = user.phoneNumber ?? '';
        selectedDate.value = user.dateOfBirth;
      }
      return null;
    }, []);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state.status == AuthStatus.profileUpdated) {
                      AppSnackBar.show(context, message: AppStrings.profileUpdated.tr());
                      AppNavigator.pop();
                    } else if (state.status == AuthStatus.error) {
                      AppSnackBar.show(context, message: state.errorMessage ?? '', isError: true);
                    }
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          _buildProfilePicture(),
                          const SizedBox(height: 24),
                          GlassNameField(controller: nameController),
                          const SizedBox(height: 16),
                          GlassPhoneField(controller: phoneController),
                          const SizedBox(height: 16),
                          _buildDateField(selectedDate),
                          const SizedBox(height: 24),
                          BlocSelector<AuthCubit, AuthState, bool>(
                            selector: (state) =>
                                state.status == AuthStatus.loading,
                            builder: (context, isLoading) {
                              return GlassButton(
                                text: AppStrings.saveChanges.tr(),
                                isLoading: isLoading,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    final authState = context
                                        .read<AuthCubit>()
                                        .state;
                                    if (authState.status ==
                                        AuthStatus.authenticated) {
                                      context
                                          .read<AuthCubit>()
                                          .updateUserProfile(
                                            uid: authState.user!.uid,
                                            name: nameController.text.trim(),
                                            phoneNumber:
                                                phoneController.text
                                                        .trim()
                                                        .isNotEmpty
                                                    ? phoneController
                                                        .text
                                                        .trim()
                                                    : null,
                                            dateOfBirth: selectedDate.value,
                                          );
                                    }
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return GlassAppBar(
      title: AppStrings.editProfile.tr(),
      showBackButton: true,
    );
  }

  Widget _buildProfilePicture() {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.glassWhite,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.glassBorder, width: 2),
          ),
          child: const Icon(Icons.person, size: 60, color: Colors.white),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child:
                const Icon(Icons.camera_alt, size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(ValueNotifier<DateTime?> selectedDate) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: AppNavigator.context!,
          initialDate: selectedDate.value ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) selectedDate.value = picked;
      },
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.glassWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedDate.value != null
                        ? DateFormat('dd/MM/yyyy')
                            .format(selectedDate.value!)
                        : AppStrings.selectDateOfBirth.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedDate.value != null
                          ? Colors.white
                          : AppColors.glassWhite,
                    ),
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
  }
}
