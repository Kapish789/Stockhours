import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Current time UTC+1"),
              MyClock(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClock extends StatefulWidget {
  const MyClock({super.key});

  @override
  _MyClockState createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    // Update time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void updateTime() {
    setState(() {
      currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentTime,
      style: const TextStyle(fontSize: 40),
    );
  }
}
