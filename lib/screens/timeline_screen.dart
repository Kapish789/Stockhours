import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_hours/services/preferences.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    ColorScheme themeColors = Theme.of(context).colorScheme;
    Preferences prefs = Provider.of<Preferences>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prefs.timezoneFromUTC != 0
                    ? "Current time in UTC${prefs.timezoneFromUTC.isNegative ? "" : "+"}${prefs.timezoneFromUTC.toString().characters.last == "0" ? prefs.timezoneFromUTC.toInt() : prefs.timezoneFromUTC}"
                    : "Current time in UTC",
                style: TextStyle(
                  color: themeColors.inversePrimary,
                ),
              ),
              CurrentTimeClock(
                addToUtc: prefs.timezoneFromUTC,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentTimeClock extends StatefulWidget {
  const CurrentTimeClock({
    super.key,
    required this.addToUtc,
  });

  final double addToUtc;

  @override
  _CurrentTimeClockState createState() => _CurrentTimeClockState();
}

class _CurrentTimeClockState extends State<CurrentTimeClock> {
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    // Update time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime(widget.addToUtc);
    });
  }

  void updateTime(double addToUtc) async {
    setState(() {
      currentTime = DateFormat('HH:mm:ss').format(DateTime.now()
          .toUtc()
          .add(Duration(minutes: (addToUtc * 60).toInt())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentTime,
      style: TextStyle(
          fontSize: 40, color: Theme.of(context).colorScheme.inversePrimary),
    );
  }
}
