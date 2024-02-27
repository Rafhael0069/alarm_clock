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
  TimeOfDay time = TimeOfDay.now();
  bool newAlarm = true;
  late ListController listController;
  String title = 'Novo alarme';

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    index = ModalRoute.of(context)!.settings.arguments as int?;
    listController = Provider.of<ListController>(context);

    if (index != null) {
      newAlarm = false;
      title = 'Alarme';
      var item = listController.listItens[index!];
      time = item.time;
      timeInput.text = item.time.format(context);
      nameInput.text = item.name;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final listController = Provider.of<ListController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                        initialTime: time,
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
              child: newAlarm? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Alarm alarm = Alarm(nameInput.text, time);
                  listController.addItem(alarm);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ): OutlinedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Colors.blue,
                    style: BorderStyle.solid,
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                   Alarm alarm = Alarm(nameInput.text, time);
                   listController.updateItem(index!, alarm);
                   Navigator.pop(context);
                },
                child: const Text('Atualizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
