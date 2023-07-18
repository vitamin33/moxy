import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../constant/icon_path.dart';
import '../../../../../domain/admin/dashboard/dashboard_cubit.dart';
import '../../../../../domain/admin/dashboard/dashboard_state.dart';
import '../../../../components/overview_chart.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Material(
              color: AppTheme.pink,
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      AnimatedOpacity(
                        opacity: state.selectedDate != null ? 1 : 0,
                        duration:const Duration(seconds: 1),
                        child: AnimatedSize(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          child: state.selectedDate != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Date Range: ${state.selectedDate?.start.toString().split(' ')[0]} - ${state.selectedDate?.end.toString().split(' ')[0]}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: AppTheme.gray),
                                        ),
                                      )
                                    ])
                              : Container(),
                        ),
                      ),
                      totalBalance(state.totalBalance),
                      const SizedBox(
                        height: 20,
                      ),
                      totalProduct(state.totalProduct),
                      const SizedBox(
                        height: 20,
                      ),
                      earning(context),
                      const SizedBox(
                        height: 20,
                      ),
                      Chart()
                    ])),
              )),
        );
      },
    );
  }
}

totalBalance(totalBalance) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: AppTheme.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: AppTheme.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(
                IconPath.wallet,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Balance',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$ ${totalBalance.toString()}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

totalProduct(totalProduct) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: AppTheme.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: AppTheme.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(
                IconPath.orders,
                color: Colors.white,
                width: 30,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Product',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${totalProduct}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

earning(context) {
  return Container(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppTheme.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: AppTheme.green,
                        radius: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Earning',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$ 23.343',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'from last mo',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.gray),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppTheme.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: AppTheme.darkPink,
                        radius: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Earning',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$ 23.343',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'from last weak',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.gray),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
