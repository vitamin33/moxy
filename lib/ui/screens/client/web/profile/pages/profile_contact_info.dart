import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/ui/components/custom_button.dart';

import '../../../../../../domain/client/profile/profile_cubit.dart';
import '../../../../../../domain/client/profile/profile_state.dart';
import '../../../../components/profile_textfield.dart';

class ProfileContactInfo extends StatelessWidget {
  const ProfileContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Контактна інформація',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
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
                        ),
                        const SizedBox(height: 5),
                        ProfileTextField(
                          title: 'Прізвище',
                          controller: cubit.secondnameController,
                          maxLines: 1,
                          onChanged: (value) {
                            cubit.secondNameChanged(value);
                          },
                        ),
                        const SizedBox(height: 5),
                        ProfileTextField(
                          title: 'Телефон',
                          controller: cubit.mobileNumberController,
                          maxLines: 1,
                          onChanged: (value) {
                            cubit.phoneNumberChanged(value);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                          ],
                        ),
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileTextField(title: 'Старий пароль'),
                        SizedBox(height: 5),
                        ProfileTextField(title: 'Новий пароль'),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                title: 'Зберегти',
                onTap: () {},
                buttonWidth: 200,
              )
            ],
          ),
        );
      },
    );
  }
}
