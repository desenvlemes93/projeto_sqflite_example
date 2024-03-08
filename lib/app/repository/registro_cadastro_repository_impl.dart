import 'dart:developer';
import 'package:projeto_horas_com_mysql/app/core/database_sql_lite.dart';
import 'package:projeto_horas_com_mysql/app/model/registro_model.dart';
import './registro_cadastro_repository.dart';

class RegistroCadastroRepositoryImpl implements RegistroCadastroRepository {
  @override
  Future<void> registrarCadastro(RegistroModel model) async {
    try {
      final database = await DatabaseSqlLite().openConnection();

      await database.execute(
        'insert into registro values (null,?,?,?,?)',
        [
          model.nome,
          model.data.toIso8601String(),
          model.hora,
          model.tipoEntrada,
        ],
      );

      database.close();
    } on Exception catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<RegistroModel>> loadingRegistro() async {
    final database = await DatabaseSqlLite().openConnection();

    var data = await database.rawQuery('select * from registro');    

    return data.map((e) => RegistroModel.fromMap(e)).toList();   
  }
}
