import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/ui/components/custom_textfield.dart';

import '../../../constant/icon_path.dart';
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
          final cubit = context.read<FooterCubit>();
          return Container(
            decoration: const BoxDecoration(color: AppTheme.pink),
            width: double.infinity,
            height: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                emailColumn(cubit, state, theme),
                menuColumn(theme),
                contactColumn(theme)
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget emailColumn(FooterCubit cubit, FooterState state, AppTheme theme) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        SvgPicture.asset(
          IconPath.moxyLogoWeb,
          width: 100,
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 290,
          child: Text(
            "ПІДПИШИСЬ ЩОБ ОТРИМАТИ КАШБЕК \n -15% ВІД ПЕРШОГО ЗАМОВЛЕННЯ",
            overflow: TextOverflow.visible,
            maxLines: 5,
            softWrap: true,
            style: theme.headline2Text,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
            width: 300,
            child: Stack(
              children: [
                TextField(
                  controller: cubit.userEmailController,
                  maxLines: 1,
                  onChanged: cubit.emailChanged,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: isValid(state.errors.emailUser)
                                  ? AppTheme.pinkDark
                                  : AppTheme.red))),
                ),
                Positioned(
                    top: 20,
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          cubit.sendEmail();
                        },
                        child: SvgPicture.asset(IconPath.textFieldArrowWeb)))
              ],
            )),
        const SizedBox(height: 20),
        Row(
          children: [
            GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      IconPath.instagramIcon,
                      color: AppTheme.white,
                    ),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      IconPath.tikTokIcon,
                      color: AppTheme.white,
                    ),
                  ),
                )),
          ],
        ),
      ],
    ),
  );
}

Widget menuColumn(AppTheme theme) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'МЕНЮ',
        style: theme.mediumBoltText,
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text('Доставка і оплата',
              style: theme.mediumText.copyWith(
                  color: isHovered ? AppTheme.gray : AppTheme.black,
                  decoration: isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none));
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text('Обмін та повернення ',
              style: theme.mediumText.copyWith(
                  color: isHovered ? AppTheme.gray : AppTheme.black,
                  decoration: isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none));
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text('Як обрати розмір?',
              style: theme.mediumText.copyWith(
                  color: isHovered ? AppTheme.gray : AppTheme.black,
                  decoration: isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none));
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text('Як отримати кешбек?',
              style: theme.mediumText.copyWith(
                  color: isHovered ? AppTheme.gray : AppTheme.black,
                  decoration: isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none));
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text('Запитання',
              style: theme.mediumText.copyWith(
                  color: isHovered ? AppTheme.gray : AppTheme.black,
                  decoration: isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none));
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text('Політика конфеденційності',
              style: theme.mediumText.copyWith(
                  color: isHovered ? AppTheme.gray : AppTheme.black,
                  decoration: isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none));
        }),
      ),
    ],
  );
}

Widget contactColumn(AppTheme theme) {
  return Column(
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
      ]);
}
