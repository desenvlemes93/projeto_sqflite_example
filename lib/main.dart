import 'package:flutter/material.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/home_page.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/listagem/controller/listagem_registro_controller.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/listagem/controller/listagem_registro_state.dart';
import 'package:projeto_horas_com_mysql/app/repository/registro_cadastro_repository.dart';
import 'package:projeto_horas_com_mysql/app/repository/registro_cadastro_repository_impl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RegistroCadastroRepository>(
          create: (context) => RegistroCadastroRepositoryImpl(),
        ),
        Provider<ListagemRegistroController>(
          create: (context) => ListagemRegistroController(ListagemInitial()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
