import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/navigation/home_router_cubit.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/loader.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../domain/create_user/create_user_cubit.dart';
import '../../../../domain/create_user/create_user_effects.dart';
import '../../../../domain/create_user/create_user_state.dart';
import '../../../../theme/app_theme.dart';
import '../../components/paste_text_field.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateUserCubit cubit = CreateUserCubit();
    cubit.effectStream.listen((effect) {
      if (effect is DataParseFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: 'Unable to parse data.'));
      }
      if (effect is ApiRequestFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: effect.failureText));
      }
      if (effect is UserValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Wrong input, please check text fields.'));
      }
      if (effect is UserCreatedSuccess) {
        context.read<HomeRouterCubit>().goToCustomers();
      }
    });
    return BlocProvider<CreateUserCubit>(
      create: (BuildContext context) => cubit,
      child: BlocBuilder<CreateUserCubit, CreateUserState>(
        builder: (context, state) {
          final cubit = context.read<CreateUserCubit>();
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Material(
                    color: AppTheme.pink,
                    child: state.isLoading
                        ? loader()
                        : Column(
                            children: [
                              _buildUserDataWidget(cubit, state),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: _buildAddUserButton(state, cubit),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildUserDataWidget(CreateUserCubit cubit, CreateUserState state) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: Column(
        children: [
          PasteTextField(
            title: ' First Name',
            maxLines: 1,
            controller: cubit.firstNameController,
            onChanged: cubit.firstNameChanged,
            validation: true,
            onPasted: () => cubit.firstNamePasted(),
          ),
          const SizedBox(
            height: 10,
          ),
          PasteTextField(
            title: 'Second Name',
            maxLines: 1,
            controller: cubit.secondNameController,
            onChanged: cubit.secondNameChanged,
            validation: true,
            onPasted: () => cubit.secondNamePasted(),
          ),
          const SizedBox(
            height: 10,
          ),
          PasteTextField(
            title: 'Phone Number',
            controller: cubit.mobileNumberController,
            onChanged: cubit.mobileNumberChanged,
            state: state.errors.phoneNumber,
            maxLines: 1,
            onPasted: () => cubit.mobileNumberPasted(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          PasteTextField(
            title: 'City',
            maxLines: 1,
            controller: cubit.cityController,
            onChanged: cubit.cityChanged,
            validation: false,
            onPasted: () => cubit.cityPasted(),
          ),
          const SizedBox(
            height: 10,
          ),
          PasteTextField(
            title: 'Instagram',
            maxLines: 1,
            controller: cubit.instagramController,
            onChanged: cubit.instagramChanged,
            validation: false,
            onPasted: () => cubit.instagramPasted(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.paste),
                ),
                tooltip: 'Parse data from clipboard',
                onPressed: () {
                  cubit.tryToParseDataFromClipboard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddUserButton(CreateUserState state, CreateUserCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: CustomButton(
        buttonWidth: 200,
        title: "Create user",
        state: state.isLoading ? ButtonState.loading : ButtonState.idle,
        onTap: cubit.createGuestUser,
      ),
    );
  }
}
