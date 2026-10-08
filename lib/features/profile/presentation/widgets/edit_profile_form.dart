import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/utils/widget/glass_button.dart';
import '../../../../core/utils/widget/glass_name_field.dart';
import '../../../../core/utils/widget/glass_phone_field.dart';
import '../cubit/profile_cubit.dart';
import 'edit_date_field.dart';
import 'edit_profile_picture.dart';

/// Edit form — StatefulWidget only owns the text controllers; the date
/// value/display and the save payload live in ProfileCubit (Zero UI Logic,
/// flutter_hooks is banned project-wide).
class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Form wiring only: seeds text fields from the already-formatted state.
    final profile = context.read<ProfileCubit>().state;
    if (_nameController.text.isEmpty) {
      _nameController.text = profile.name;
      _phoneController.text = profile.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const EditProfilePicture(),
            const SizedBox(height: 24),
            GlassNameField(
              controller: _nameController,
              isLightScreen: true,
            ),
            const SizedBox(height: 16),
            GlassPhoneField(
              controller: _phoneController,
              isLightScreen: true,
            ),
            const SizedBox(height: 16),
            const EditDateField(),
            const SizedBox(height: 24),
            BlocSelector<ProfileCubit, ProfileState, bool>(
              selector: (state) => state.status == ProfileStatus.loading,
              builder: (context, isLoading) {
                return GlassButton(
                  text: AppStrings.saveChanges.tr(),
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ProfileCubit>().updateProfile(
                        name: _nameController.text,
                        phone: _phoneController.text,
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
