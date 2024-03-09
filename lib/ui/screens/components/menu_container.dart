import 'package:flutter/material.dart';
import 'package:moxy/constant/menu_title.dart';
import 'package:moxy/ui/screens/components/custom_accordion.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class MenuContainer extends StatelessWidget {
  final MenuTitle menuTitle;
  const MenuContainer({super.key, required this.menuTitle});

  @override
  Widget build(BuildContext context) {
    switch (menuTitle) {
      case MenuTitle.delivery:
        return const MenuDeliveryAndPayment();
      case MenuTitle.change:
        return const MenuExChangeAndReturn();
      case MenuTitle.questions:
        return const MenuQuestions();
      case MenuTitle.privacy:
        return const MenuPrivacyPolicy();
      default:
        return const Column(
            children: [Text('Загальний вміст для невідомого типу')]);
    }
  }
}

class MenuDeliveryAndPayment extends StatelessWidget {
  const MenuDeliveryAndPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'Доставка та оплата',
          style: theme.bigTitleBoltText,
        ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ОПЛАТА',
              style: theme.headlineBoltText,
            ),
            const SizedBox(height: 8),
            Text(
              'При оформленні замовлення необхідно обрати спосіб Оплати. Магазин MOXY пропонує 2 методи оплати придбаного товару:',
              style: theme.largeSemiBoltText,
            ),
            const SizedBox(height: 8),
            Text(
                '1. Онлайн, за допомогою платіжної системи LiqPay, оплата картками Visa, Mastercard чи monobank.',
                style: theme.largeSemiBoltText),
            Text('2. Післяплатою, при отриманні у відділенні “Нової пошти”*;',
                style: theme.largeSemiBoltText),
            Text(
                '*Уточнюємо: якщо Вам зручно отримати товар післяплатою, потрібно оплатити комісію у розмірі 20 грн, за грошовий переказ і додати до загальної суми замовлення 2%. Це відбувається згідно з вимогами транспортної компанії “Нова пошта”.',
                style: theme.largeSemiBoltText),
            const SizedBox(height: 16),
            Text('ДОСТАВКА', style: theme.headlineBoltText),
            const SizedBox(height: 8),
            Text('– Нова Пошта', style: theme.largeSemiBoltText),
            Text(
                'Отримати замовлення Ви можете у будь-якому найближчому відділенні транспортної компанії “Нова пошта” або замовити кур’єрську доставку за вказаною Вами адресою. Цей вид доставки оплачується за тарифами Нової пошти.',
                style: theme.largeSemiBoltText),
            const SizedBox(height: 8),
            Text(
                'Якщо Ви обрали сплатити замовлення за допомогою післяплати, з Вас буде взята комісія в розмірі 20 грн, яка стягується за грошовий переказ, а також 2% від загальної суми замовлення.',
                style: theme.largeSemiBoltText),
            Text(
                'Середній термін доставки посилки Україною — 1-3 дні. Просимо своїх Клієнтів перевіряти товар на цілісність у відділенні Нової пошти. У разі пошкодження посилки при здійсненні доставки Новою поштою, кошти за пошкоджений товар відшкодовує Компанія – «Нова пошта», оскільки весь товар перед відправленням страхується на повну вартість.',
                style: theme.largeSemiBoltText),
          ],
        )
      ]),
    );
  }
}

class MenuExChangeAndReturn extends StatelessWidget {
  const MenuExChangeAndReturn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'Обмін та повернення',
          style: theme.bigTitleBoltText,
        ),
        const SizedBox(height: 30),
        Text(
          '30 ДНІВ ПОВЕРНЕННЯ ТА 14 ДНІВ БЕЗКОШТОВНОГО ПОВЕРНЕННЯ',
          style: theme.headline2Text,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Як зробити повернення?',
              style: theme.headlineBoltText,
            ),
            const SizedBox(height: 8),
            Text(
                'Якщо ви хочете повернути замовлення чи товар, знайте, у Fidelitti це дуже просто. Повернення здійснюється через кур’єрські компанії Нова Пошта та Meest.',
                style: theme.largeSemiBoltText),
            const SizedBox(height: 8),
            Text(
                'Пам’ятайте, що ви маєте 30 календарних днів з моменту отримання посилки і що товари повинні відповідати певним умовам.',
                style: theme.largeSemiBoltText),
            const SizedBox(height: 8),
            Text(
              'ОБМІН ТОВАРУ',
              style: theme.headlineBoltText,
            ),
            Text(
                'Процес обміну грунтується  на поверненні продукту,  який ви хочете обміняти, у непошкодженому вигляді (у тому вигляді, у якому ви його отримали від нас), з наступним розміщенням нового замовлення на бажаний продукт.',
                style: theme.largeSemiBoltText),
            const SizedBox(height: 8),
            Text(
                'Наш магазин поверне вам гроші за повернутий товар (який ви хочете обміняти), як тільки повернення буде прийнято на нашому складі.',
                style: theme.largeSemiBoltText),
            const SizedBox(height: 8),
            Text(
                'Вам потрібно буде оформити нове замовлення якнайшвидше для резервування товару на складі.',
                style: theme.largeSemiBoltText),
          ],
        ),
      ]),
    );
  }
}


class MenuQuestions extends StatelessWidget {
  const MenuQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Найчастіші Запитання'.toUpperCase(),
            style: theme.bigTitleBoltText,
          ),
          const SizedBox(height: 30),
          CustomAccordion(
              expandedTitleBackgroundColor: AppTheme.pink,
              titleChild: Text(
                'Як зробити замовлення',
                style: theme.headlineBoltText,
              ),
              contentChild: Text(
                'Для того, щоб придбати сумку чи аксесуар, перейдіть у відповідний розділ каталогу, оберіть потрібний товар та тисніть кнопку «купити», після чого товар буде додано у кошик. Щоб завершити замовлення, перейдіть у кошик. У кошику є два варіанти завершення покупки: 1. Швидке замовлення. В цьому випадку ви залишаєте замовлення та вказуєте лише імя та номер телефону, деталі уточнить менеджер магазину. 2. Повне оформлення (рекомендуємо). Натискаючи копку «Купити» у кошику, ви перейдете на наступні сторінки де потрібно вказати дані одержувача та обрати відділення НП, далі ви оберете спосіб оплати та перевірите своє замовлення. В залежності від способу оплати, залишиться тільки оплатити його через Liq Pay або просто підтвердити.',
                style: theme.titleSemiBoltText,
              )),
          CustomAccordion(
              expandedTitleBackgroundColor: AppTheme.pink,
              titleChild: Text(
                'Які є варіанти доставки?',
                style: theme.headlineBoltText,
              ),
              contentChild: Text(
                'Варіанти доставки: Ми доставляємо замовлення компанією «Нова Пошта», зазвичай впродовдж 2-3 днів. Є три варіанти доставки: у відділення, у поштомат (якщо розмір посилки відповідає габаритам) або адресна доставка курьєром. Вартість доставки розраховується індивідуально за тарифами «Нової Пошти». Та, якщо ваше замовлення буде на суму більше 1 500 грн — доставку оплатимо ми.',
                style: theme.titleSemiBoltText,
              )),
          CustomAccordion(
              expandedTitleBackgroundColor: AppTheme.pink,
              titleChild: Text(
                'Що робити, якщо виявили брак або несподобався товар?',
                style: theme.headlineBoltText,
              ),
              contentChild: Text(
                'Протягом 14 днів з дня покупки ви можете замовити повернення товару або обмін на інший. Для з’ясування деталей та оформлення повернення напишіть на пошту Support@moxy.ua',
                style: theme.titleSemiBoltText,
              )),
          CustomAccordion(
              expandedTitleBackgroundColor: AppTheme.pink,
              titleChild: Text(
                'Як відбувається оплата?',
                style: theme.headlineBoltText,
              ),
              contentChild: Text(
                'Оплата декількома способами: онлайн оплата через LiqPay (картка, apple pay, google pay), оплата готівкою на пошті, оплата на розрахунковий рахунок ФОП.',
                style: theme.titleSemiBoltText,
              )),
          CustomAccordion(
              expandedTitleBackgroundColor: AppTheme.pink,
              titleChild: Text(
                'Що робити, якщо щось непрацює на сайті?',
                style: theme.headlineBoltText,
              ),
              contentChild: Text(
                'Напишіть, буль ласка, на пошту Support@moxy.ua Будемо дуже вдячні! ',
                style: theme.titleSemiBoltText,
              )),
        ],
      ),
    );
  }
}

class MenuPrivacyPolicy extends StatelessWidget {
  const MenuPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'Політика конфеденційності'.toUpperCase(),
          style: theme.bigTitleBoltText,
        ),
        const SizedBox(height: 30),
        Text(
          'Політика конфіденційності щодо обробки персональних даних Ваша конфіденційність є одним з наших основних зобовязань, і тому ми докладаємо всіх зусиль для обробки ваших персональних даних відповідно до принципів, викладених у застосовному законодавстві, у повній відповідності до Регламенту (ЄС) 2016/679 («Загальне положення про захист даних» або "GDPR"). Одним з основних принципів цієї правової бази є прозорість, тому ми підготували цей документ, за допомогою якого ми хочемо поінформувати вас про те, як ми збираємо, використовуємо, передаємо та захищаємо ваші особисті дані, коли ви взаємодієте з Fidelitti щодо продуктів та послуг, які ми надаємо.Ми залишаємо за собою право періодично оновлювати та змінювати цю Політику конфіденційності, щоб відображати будь-які зміни у тому, як ми обробляємо ваші персональні дані, або будь-які зміни у законодавчих вимогах. У разі будь-якої такої зміни ми будемо відображати змінену версію Політики конфіденційності на нашому веб-сайті, тому ми просимо вас періодично перевіряти зміст цієї Політики конфіденційності.Хто ми і як ви можете звязатися з намиFidelitti – зареєстрована торгова марка Fidelitti Ukraine, (далі «Fidelitti», «fidelitti.ua» або «ми»). Відповідно до законодавства про захист даних, ми є оператором при обробці ваших персональних даних.Оскільки ми завжди відкриті для вашої думки, а також для надання вам будь-якої додаткової інформації, яка може знадобитися щодо обробки ваших даних, ми рекомендуємо вам звязатися зі співробітником захисту даних Fidelitti за адресою електронної пошти gdpr@fidelitti.com.',
          style: theme.titleSemiBoltText,
        )
      ]),
    );
  }
}
