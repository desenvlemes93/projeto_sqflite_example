import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_horas_com_mysql/app/core/database_sql_lite.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/cadastro/cadastro_page.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/listagem/listagem_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _datanase();
  }

  Future<void> _datanase() async {
    await DatabaseSqlLite().openConnection();
  }

  int indice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ricardo, seja bem vindo!'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Cadastro',
            icon: Icon(Icons.person_add_sharp),
          ),
          BottomNavigationBarItem(
            label: 'Listagem',
            icon: Icon(Icons.list_alt_rounded),
          ),
        ],
        currentIndex: 0,
        onTap: (value) {
          setState(() {
            indice = value;
          });
        },
      ),
      body: IndexedStack(
        index: indice,
        children: const [
          CadastroPage(),
          ListagemPage(),
        ],
      ),
    );
  }
}
