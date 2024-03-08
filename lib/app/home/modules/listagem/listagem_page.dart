import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/listagem/controller/listagem_registro_controller.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/listagem/controller/listagem_registro_state.dart';

class ListagemPage extends StatefulWidget {
  const ListagemPage({super.key});

  @override
  State<ListagemPage> createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  @override
  void initState() {
    _buscar();
    super.initState();
  }

  Future<void> _buscar() async {
    final teste = context.read<ListagemRegistroController>();
    await teste.loadingRegistro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await _buscar();
      }),
      body: BlocConsumer<ListagemRegistroController, ListagemRegistroState>(
        listener: (context, state) {
          switch (state) {
            case ListagemInitial():
              break;
            case ListagemLoading():
              const CircularProgressIndicator(
                color: Colors.red,
              );

            case _:
              const SizedBox.shrink();
          }
        },
        builder: (context, state) {
          return switch (state) {
            ListagemLoading() => const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ListagemLoaded(listaRegistro: var listaRegistro) =>
              ListView.builder(
                itemCount: listaRegistro.length,
                itemBuilder: (context, index) {
                  var registro = listaRegistro[index];
                  return ListTile(
                    trailing: Text(
                      style: TextStyle(
                        color: registro.tipoEntrada == 'E'
                            ? Colors.green
                            : Colors.red,
                      ),
                      registro.tipoEntrada == 'E' ? 'Entrada' : 'Saida',
                    ),
                    leading: Text(registro.hora),
                    title: Text(
                        registro.nome == '' ? 'Nâo Encontrado' : registro.nome),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(registro.data),
                    ),
                  );
                },
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
