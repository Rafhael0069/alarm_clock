// ignore_for_file: library_private_types_in_public_api

import 'package:alarm_clock/models/alarm.dart';
import 'package:mobx/mobx.dart';
part 'item_controller.g.dart';

/*
Comandos para rodar o build
Gerar os arquivos -> dart run build_runner build
Salvar as alterações automaticamento nos arquivos -> dart run build_runner watch
Linpar os arquivos -> dart run build_runner clean
 */

class ItemController = _ItemController with _$ItemController;

abstract class _ItemController with Store {

  _ItemController(this.alarm);

  final Alarm alarm;

}