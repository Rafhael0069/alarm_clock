import 'package:alarm_clock/controllers/list_controller.dart';
import 'package:alarm_clock/pages/home.dart';
import 'package:alarm_clock/pages/new_alarm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [Provider<ListController>(create: (_) => ListController())],
    child: MaterialApp(
      initialRoute: "/",
      routes: {"/new_alarm": (context) => const NewAlarm()},
      home: const Home(),
    ),
  ));
}
