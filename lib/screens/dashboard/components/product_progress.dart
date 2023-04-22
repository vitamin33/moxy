import 'package:flutter/material.dart';

import '../../../components/stepper.dart';
import '../../../constant/menu.dart';
import '../../../theme/app_theme.dart';

List<Menu> tabs = const [
  Menu(title: 'Details', icon: Icons.folder_copy),
  Menu(icon: Icons.photo_camera_rounded, title: 'Branding'),
  Menu(icon: Icons.monetization_on, title: 'Pricing'),
  Menu(icon: Icons.summarize_outlined, title: 'Summary'),
];

class CreateProductProgress extends StatelessWidget {
  final Function(int) onChangePage;
  const CreateProductProgress({
    Key? key,
    required this.count,
    required this.onChangePage,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: Stack(
          children: [
            Positioned(
              top: 35,
              child: StepperProgressBar(count: count),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                tabs.length,
                (index) {
                  final hightlight = (index + 1) * 25;

                  return InkWell(
                    onTap: () {
                      onChangePage(index);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: hightlight <= count
                              ? Theme.of(context).highlightColor
                              : Theme.of(context).canvasColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              tabs[index].icon,
                              size: 50,
                              color: hightlight <= count
                                  ? Theme.of(context).highlightColor
                                  : Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.elementSpacing),
                        Text(
                          tabs[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: hightlight <= count
                                      ? Theme.of(context).highlightColor
                                      : Theme.of(context)
                                          .highlightColor
                                          .withOpacity(.5)),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
