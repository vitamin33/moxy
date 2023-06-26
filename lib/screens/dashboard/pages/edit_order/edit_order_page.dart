import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/components/custom_button.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../constant/order_status.dart';

import '../../../../constant/image_path.dart';

class EditOrderPage extends StatelessWidget {
  const EditOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.white,
        body: Material(
            child: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: SingleChildScrollView(
            child: Column(children: [
              contactDetails(),
              const SizedBox(height: 20),
              typePayment(),
              const SizedBox(height: 20),
              typeDelivery(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Date Range',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 20),
              orderStatus(context),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Edit',
                onTap: () {},
                buttonWidth: MediaQuery.of(context).size.width,
              )
            ]),
          ),
        )));
  }
}

Widget contactDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Contact Details',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              IconPath.personName,
            ),
            const Text('Rosalina Stark'),
            TextButton(onPressed: () {}, child: const Text('Change'))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(IconPath.phone),
          const Text('+913456754 34'),
          TextButton(onPressed: () {}, child: const Text('Change'))
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(IconPath.selectedProduct),
          const Text('Dior,Chanel'),
          TextButton(onPressed: () {}, child: const Text('Change'))
        ]),
      )
    ],
  );
}

Widget typePayment() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Text('Type Payment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      InkWell(
        child: Container(
            child: CircleAvatar(
          radius: 30,
          backgroundColor: AppTheme.black,
          // _renderBorder(isValid(
          //   // state.errors.quantity
          //   )),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: AppTheme.white,
            child: SvgPicture.asset(IconPath.fullPayment),
          ),
        )),
      ),
      InkWell(
        child: Container(
            child: CircleAvatar(
          radius: 30,
          backgroundColor: AppTheme.black,
          // _renderBorder(isValid(
          //   // state.errors.quantity
          //   )),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: AppTheme.white,
            child: SvgPicture.asset(IconPath.cashPayment),
          ),
        )),
      )
    ],
  );
}

Widget typeDelivery() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Text('Type Delivery',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      InkWell(
        child: Container(
          child: Image.asset(ImageAssets.novaPoshta),
        ),
      ),
      InkWell(
        child: Container(
          child: Image.asset(ImageAssets.ukrPoshta),
        ),
      )
    ],
  );
}

Widget orderStatus(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Order Status',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allStatusOrder.length,
                itemBuilder: (context, index) {
                  final status = allStatusOrder[index];
                  // final isSelected = status.statusTitle == state.status;
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppTheme.black,
                        // _renderBorder(isValid(
                        //   // state.errors.quantity
                        //   )),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: AppTheme.white,
                          child: SvgPicture.asset(status.iconPath),
                          //   // context
                          //   //     .read<CreateOrderCubit>()
                          //   //     .updateSelectedStatusTitle(newValue!);
                          // },
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Color _renderBorder(bool isValid) {
  return isValid ? AppTheme.white : Colors.red;
}

bool isValid(state) => state == null;
