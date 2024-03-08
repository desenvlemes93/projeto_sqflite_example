import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/listagem/controller/listagem_registro_state.dart';
import 'package:projeto_horas_com_mysql/app/repository/registro_cadastro_repository_impl.dart';

class ListagemRegistroController extends Cubit<ListagemRegistroState> {
  ListagemRegistroController(super.initialState);

  final repository = RegistroCadastroRepositoryImpl();

  Future<void> loadingRegistro() async {
    try {
      emit(ListagemLoading());

      final registro = await repository.loadingRegistro();

      print(registro.toList());

      emit(ListagemLoaded(listaRegistro: registro));
    } on Exception catch (e) {
      emit(ListagemInitial());
      throw Exception(e);
    }
  }
}
