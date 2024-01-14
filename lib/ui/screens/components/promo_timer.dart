import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class PromoTimer extends StatefulWidget {
  final DateTime finalDate;

  const PromoTimer({super.key, required this.finalDate});

  @override
  // ignore: library_private_types_in_public_api
  _PromoTimerState createState() => _PromoTimerState();
}

class _PromoTimerState extends State<PromoTimer> {
  late Duration duration;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    duration = widget.finalDate.difference(DateTime.now());
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimer());
  }

  void updateTimer() {
    setState(() {
      duration = widget.finalDate.difference(DateTime.now());
      if (duration.isNegative) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return SizedBox(
      child: duration.isNegative
          ? const Center(
              child: SizedBox.shrink(),
            )
          : buildTime(theme),
    );
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  Widget buildTime(AppTheme theme) {
    final days = twoDigits(duration.inDays);
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final theme = AppTheme.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Spacer(flex: 1),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(
            color: Colors.white,
            thickness: 1,
            height: 20,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimeCard(time: days, header: 'Days', theme: theme),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: buildDivider(),
            ),
            buildTimeCard(time: hours, header: 'Hours', theme: theme),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: buildDivider(),
            ),
            buildTimeCard(time: minutes, header: 'Minutes', theme: theme),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: buildDivider(),
            ),
            buildTimeCard(time: seconds, header: 'Seconds', theme: theme),
          ],
        ),
        const Spacer(flex: 7),
      ],
    );
  }

  Widget buildTimeCard(
      {required String time, required String header, required AppTheme theme}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: theme.headline4BoltText.copyWith(
            color: AppTheme.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          header,
          style: theme.mediumText.copyWith(
            color: AppTheme.white,
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return const SizedBox(
      height: 60, // Match this height with your time card's height
      child: VerticalDivider(
        color: Colors.white,
        thickness: 1,
        width: 20, // The space around the divider, adjust to your layout
      ),
    );
  }
}
