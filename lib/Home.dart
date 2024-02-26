import 'package:alarm_clock/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Controller _controller = Controller();

  _dialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Adicionar item"),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Digite uma descrição..."),
              onChanged: _controller.setNewItem,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    _controller.addItem();
                    Navigator.pop(context);
                  },
                  child: const Text("Salvar"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Despertador",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: _controller.listItens.length,
          itemBuilder: (_, index) {
            var item = _controller.listItens[index];
            return Observer(builder: (_) {
              return ListTile(
                title: Text(
                  item.title,
                  style: TextStyle(
                      decoration: item.marked ? TextDecoration.lineThrough : null,
                      color: item.marked ? Colors.grey : Colors.black),
                ),
                leading: Checkbox(
                  value: item.marked,
                  onChanged: item.changeMarker,
                ),
                onTap: () {
                  item.marked = !item.marked;
                },
              );
            });
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
