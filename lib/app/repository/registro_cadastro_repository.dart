import 'package:projeto_horas_com_mysql/app/model/registro_model.dart';

abstract interface class RegistroCadastroRepository {
  Future<void> registrarCadastro(RegistroModel model);
  Future<List<RegistroModel>> loadingRegistro();

}