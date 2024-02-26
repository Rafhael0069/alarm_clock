// ignore_for_file: use_build_context_synchronously

import 'package:alarm_clock/controllers/list_controller.dart';
import 'package:alarm_clock/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAlarm extends StatefulWidget {
  const NewAlarm({Key? key}) : super(key: key);

  @override
  State<NewAlarm> createState() => _NewAlarmState();
}

class _NewAlarmState extends State<NewAlarm> {
  TextEditingController timeInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  int? index;
  late TimeOfDay time;
  late bool newAlarm;

  @override
  void initState() {
    index = ModalRoute.of(context)!.settings.arguments as int?;

    if (index == null) {
      newAlarm = false;
    } else {
      newAlarm = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listController = Provider.of<ListController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(newAlarm ? 'Alarme' : 'Novo Alarme'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: nameInput,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Alarme',
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: timeInput,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), labelText: "Horario do alarme"),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        String formattedDate = pickedTime.format(context);

                        timeInput.text = formattedDate;
                        time = pickedTime;
                      } else {
                        print("Hora não selecionada");
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Alarm alarm = Alarm(nameInput.text, time);
                  listController.addItem(alarm);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
