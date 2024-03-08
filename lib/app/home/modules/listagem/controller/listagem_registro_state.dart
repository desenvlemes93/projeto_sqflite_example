// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:projeto_horas_com_mysql/app/model/registro_model.dart';

sealed class ListagemRegistroState {}

class ListagemInitial extends ListagemRegistroState {}

class ListagemLoading extends ListagemRegistroState {}

class ListagemLoaded extends ListagemRegistroState {
  var listaRegistro = <RegistroModel>[];
  ListagemLoaded({
    required this.listaRegistro,
  });
}
