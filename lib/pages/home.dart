import 'package:alarm_clock/controllers/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    final listController = Provider.of<ListController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despertador",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: listController.listItens.length,
          itemBuilder: (_, index) {
            var item = listController.listItens[index];
            return Observer(builder: (_) {
              return ListTile(
                title: Text(
                  item.alarm.name,
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: GestureDetector(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    listController.removeItem(index);
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/new_alarm", arguments: index);
                },
              );
            });
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/new_alarm');
        },
      ),
    );
  }
}
