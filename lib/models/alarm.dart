import 'package:flutter/material.dart';

class Alarm {
  late String name;
  late TimeOfDay time;

  Alarm(this.name, this.time);

  Alarm.fromJson(Map<String, dynamic> json)
      :name = json['name'],
        time = json['date'];

  Map<String, dynamic> toJson() => {'name': name, 'date': time};
}
