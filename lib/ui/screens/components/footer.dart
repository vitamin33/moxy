import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/screens/client/web/subscribe/subscribe_view.dart';
import 'package:moxy/utils/responsive_utils.dart';

import '../../../domain/client/footer/footer_cubit.dart';
import '../../../domain/client/footer/footer_state.dart';
import '../../theme/app_theme.dart';
import 'onhover.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return BlocProvider(
      create: (BuildContext context) => FooterCubit(),
      child: BlocBuilder<FooterCubit, FooterState>(
        builder: (context, state) {
          final isMobile = ResponsiveUtil.isMobile(context);
          return Container(
              decoration: const BoxDecoration(color: AppTheme.pink),
              width: double.infinity,
              child: isMobile
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SubscribeView(),
                          menuColumn(theme, context),
                          contactColumn(theme)
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SubscribeView(),
                        menuColumn(theme, context),
                        contactColumn(theme)
                      ],
                    ));
        },
      ),
    );
  }
}

Widget menuColumn(AppTheme theme, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'МЕНЮ',
          style: theme.mediumBoltText,
        ),
        const SizedBox(height: 22),
        GestureDetector(
          onTap: () {
            context.go(RouterProvider.menuPath('delivery'));
          },
          child: OnHover(
            builder: ((isHovered) {
              return Text('Доставка і оплата',
                  style: theme.mediumText.copyWith(
                      color: isHovered ? AppTheme.gray : AppTheme.black,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none));
            }),
          ),
        ),
        const SizedBox(height: 22),
        GestureDetector(
          onTap: () {
            context.go(RouterProvider.menuPath('change'));
          },
          child: OnHover(
            builder: ((isHovered) {
              return Text('Обмін та повернення ',
                  style: theme.mediumText.copyWith(
                      color: isHovered ? AppTheme.gray : AppTheme.black,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none));
            }),
          ),
        ),
        const SizedBox(height: 22),
        GestureDetector(
          onTap: () {
            context.go(RouterProvider.menuPath('questions'));
          },
          child: OnHover(
            builder: ((isHovered) {
              return Text('Найчастіші запитання',
                  style: theme.mediumText.copyWith(
                      color: isHovered ? AppTheme.gray : AppTheme.black,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none));
            }),
          ),
        ),
        const SizedBox(height: 22),
        GestureDetector(
          onTap: () {
            context.go(RouterProvider.menuPath('privacy'));
          },
          child: OnHover(
            builder: ((isHovered) {
              return Text('Політика конфеденційності',
                  style: theme.mediumText.copyWith(
                      color: isHovered ? AppTheme.gray : AppTheme.black,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none));
            }),
          ),
        ),
      ],
    ),
  );
}

Widget contactColumn(AppTheme theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ГРАФІК РОБОТИ',
                  style: theme.mediumBoltText,
                ),
                const SizedBox(height: 22),
                Text('Понеділок - п’ятниця з 9:00 до 21:00',
                    style: theme.mediumText),
                const SizedBox(height: 22),
                Text(
                  'Субота - п’ятниця з 10:00 до 19:00',
                  style: theme.mediumText,
                ),
              ],
            ),
          ),
          const SizedBox(height: 58),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ПІДТРИМКА',
                style: theme.mediumBoltText,
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Text(
                    'E-mail: ',
                    style: theme.mediumText,
                  ),
                  OnHover(
                    builder: ((isHovered) {
                      return Text('Support@moxy.ua',
                          style: theme.mediumText.copyWith(
                              color: isHovered ? AppTheme.gray : AppTheme.black,
                              decoration: isHovered
                                  ? TextDecoration.underline
                                  : TextDecoration.none));
                    }),
                  ),
                ],
              ),
            ],
          )
        ]),
  );
}
