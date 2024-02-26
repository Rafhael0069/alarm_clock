import 'package:alarm_clock/item_controller.dart';
import 'package:mobx/mobx.dart';
part 'controller.g.dart';

/*
Comandos para rodar o build
Gerar os arquivos -> dart run build_runner build
Salvar as alterações automaticamento nos arquivos -> dart run build_runner watch
Linpar os arquivos -> dart run build_runner clean
 */

class Controller = _Controller with _$Controller;

abstract class _Controller with Store {
  @observable
  String newItem = "";

  @action
  void setNewItem(String value) => newItem = value;

  @observable
  ObservableList<ItemController> listItens = ObservableList<ItemController>();

  @action
  void addItem() {
    listItens.add(ItemController(newItem));
    print(listItens);
  }
}