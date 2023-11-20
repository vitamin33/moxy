import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';
import 'package:moxy/ui/screens/client/web/checkout/search_city_dropdown.dart';
import 'package:moxy/ui/screens/client/web/checkout/search_warehouse_dropdown.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../../domain/client/profile/profile_state.dart';

class ProfileAdress extends StatelessWidget {
  const ProfileAdress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final theme = AppTheme.of(context)!;
        final cubit = context.read<ProfileCubit>();
        return SizedBox(
          width: double.infinity,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Адресна Книга',
                  style: theme.headline3BoltText,
                ),
                const SizedBox(height: 40),
                Text('Місто', style: theme.headlineSemiBoltText),
                SearchCityDropdown(
                    selectedWarehouse: state.profile.warehouse,
                    onChanged: (city) {
                      cubit.selectCity(city);
                    },
                    selectedCity: state.profile.city),
                const SizedBox(height: 30),
                Text(
                  'Відділення',
                  style: theme.headlineSemiBoltText,
                ),
                SearchWarehouseDropdown(
                    selectedWarehouse: state.profile.warehouse,
                    onChanged: (warehouse) {
                      cubit.selectWarehouse(warehouse);
                    },
                    selectedCity: state.profile.city),
              ],
            ),
          ),
        );
      },
    );
  }
}
