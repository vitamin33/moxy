import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class AttendanceScreen extends StatefulWidget {
  final DateTime finalDate;

  const AttendanceScreen({super.key, required this.finalDate});

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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
      width: 200,
      child: duration.isNegative
          ? Center(
              child: Text(
                'Акція завершена',
                style:
                    theme.headlineSemiBoltText.copyWith(color: AppTheme.white),
              ),
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: days, header: 'DAY', theme: theme),
        const SizedBox(width: 5),
        buildTimeCard(time: hours, header: 'HOUR', theme: theme),
        const SizedBox(width: 5),
        buildTimeCard(time: minutes, header: 'MIN', theme: theme),
        const SizedBox(width: 5),
        buildTimeCard(time: seconds, header: 'SEC', theme: theme),
      ],
    );
  }

  Widget buildTimeCard(
      {required String time, required String header, required AppTheme theme}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(time, style: theme.headline3BoltText),
        ),
        const SizedBox(height: 10),
        Text(header, style: theme.mediumText),
      ],
    );
  }
}
