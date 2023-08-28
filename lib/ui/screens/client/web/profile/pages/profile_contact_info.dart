import 'package:flutter/material.dart';
import 'package:moxy/ui/components/custom_button.dart';

import '../../../../components/profile_textfield.dart';

class ProfileContactInfo extends StatelessWidget {
  const ProfileContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
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
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ProfileTextField(
                      title: 'Ваше імя',
                    ),
                    SizedBox(height: 5),
                    ProfileTextField(
                      title: 'Прізвище',
                    ),
                    SizedBox(height: 5),
                    ProfileTextField(
                      title: 'Email',
                    ),
                    SizedBox(height: 5),
                    ProfileTextField(
                      title: 'Телефон',
                    ),
                  ],
                ),
                Column(
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
  }
}
