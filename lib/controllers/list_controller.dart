// ignore_for_file: library_private_types_in_public_api

import 'package:alarm_clock/models/alarm.dart';
import 'package:mobx/mobx.dart';
part 'list_controller.g.dart';

/*
Comandos para rodar o build
Gerar os arquivos -> dart run build_runner build
Salvar as alterações automaticamento nos arquivos -> dart run build_runner watch
Linpar os arquivos -> dart run build_runner clean
 */

class ListController = _ListController with _$ListController;

abstract class _ListController with Store {

  @observable
  ObservableList<Alarm> listItens = ObservableList<Alarm>();

  @action
  void addItem(Alarm newAlarm) {
    listItens.add(newAlarm);
  }

  @action
  void removeItem(int index) {
    listItens.removeAt(index);
  }

  @action
  void updateItem(int index, Alarm alarm) {
    listItens.setAll(index, [alarm]);
  }
}