import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../../domain/client/profile/profile_cubit.dart';
import '../../../../../../domain/client/profile/profile_state.dart';
import '../../../../components/profile_textfield.dart';

class ProfileContactInfo extends StatelessWidget {
  const ProfileContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final theme = AppTheme.of(context)!;
        final cubit = context.read<ProfileCubit>();
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Контактна інформація',
                  style: theme.headline3BoltText,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ProfileTextField(
                            title: 'Ваше імя',
                            controller: cubit.firstnameController,
                            maxLines: 1,
                            onChanged: (value) {
                              cubit.firstNameChanged(value);
                            },
                            validation: true,
                            state: state.errors.firstName,
                          ),
                          const SizedBox(height: 5),
                          ProfileTextField(
                            title: 'Прізвище',
                            controller: cubit.secondnameController,
                            maxLines: 1,
                            onChanged: (value) {
                              cubit.secondNameChanged(value);
                            },
                            validation: true,
                            state: state.errors.secondName,
                          ),
                          const SizedBox(height: 5),
                          ProfileTextField(
                            title: 'Телефон',
                            controller: cubit.mobileNumberController,
                            maxLines: 1,
                            onChanged: (value) {
                              cubit.phoneNumberChanged(value);
                            },
                            validation: true,
                            state: state.errors.phoneNumber,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileTextField(
                            title: 'Старий пароль',
                            controller: cubit.oldPasswordController,
                            maxLines: 1,
                            onChanged: (value) {
                              cubit.oldPasswordChanged(value);
                            },
                            validation: true,
                            state: state.errors.oldPassword,
                          ),
                          const SizedBox(height: 5),
                          ProfileTextField(
                            title: 'Новий пароль',
                            controller: cubit.newPasswordController,
                            maxLines: 1,
                            onChanged: (value) {
                              cubit.newPasswordChanged(value);
                            },
                            validation: true,
                            state: state.errors.newPassword,
                          ),
                          const SizedBox(height: 5),
                          ProfileTextField(
                            title: 'Підтвердити новий пароль',
                            controller: cubit.repeatNewPasswordController,
                            maxLines: 1,
                            onChanged: (value) {
                              cubit.repeatNewPasswordChanged(value);
                            },
                            validation: true,
                            state: state.errors.reapeatNewPassword,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
