import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/cadastro/controller/cadastro_controller.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/cadastro/controller/registro_cadastro_state.dart';
import 'package:projeto_horas_com_mysql/app/home/modules/listagem/controller/listagem_registro_controller.dart';
import 'package:projeto_horas_com_mysql/app/model/registro_model.dart';
import 'package:projeto_horas_com_mysql/app/repository/registro_cadastro_repository.dart';
import 'package:provider/provider.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  DateTime dataInicial = DateTime.now();
  TimeOfDay horaInicial = TimeOfDay.now();
  TipoEntrada? tipoEntradaMulti;
  String entrada = '';
  final _descricaoEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _descricaoEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CadastroController>();
    final listagem = context.read<ListagemRegistroController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar demanda'),
      ),
      body: CustomScrollView(
        physics: const ScrollPhysics(),        
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _descricaoEC,
                        decoration: InputDecoration(
                          label: const Text('Descrição'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          var data = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2030),
                              ) ??
                              DateTime.now();

                          setState(() {
                            dataInicial = data;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Selecione uma data')),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Center(
                                child: Center(
                                    child: Text(DateFormat('dd/MM/yyyy')
                                        .format(dataInicial))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          var hora = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          setState(() {
                            horaInicial = hora!;
                          });
                        },
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text('Selecione uma hora'),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Center(
                                child: Text(
                                  horaInicial.format(context).toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      RadioListTile<TipoEntrada>(
                          title: const Text('Entrada'),
                          value: TipoEntrada.entrada,
                          groupValue: tipoEntradaMulti,
                          onChanged: (value) {
                            setState(
                              () {
                                entrada = 'E';
                                tipoEntradaMulti = value;
                              },
                            );
                          }),
                      RadioListTile<TipoEntrada>(
                          title: const Text('Saida'),
                          value: TipoEntrada.saida,
                          groupValue: tipoEntradaMulti,
                          onChanged: (value) {
                            setState(() {
                              entrada = 'S';
                              tipoEntradaMulti = value;
                            });
                          }),
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final model = RegistroModel(
                                    nome: _descricaoEC.text,
                                    data: dataInicial,
                                    hora:
                                        horaInicial.format(context).toString(),
                                    tipoEntrada: entrada,
                                  );
                                  await controller.register(model);

                                  listagem.loadingRegistro();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          'Cadastro realizado com Sucesso'),
                                    ),
                                  );
                                },
                                child: BlocConsumer<CadastroController,
                                    RegistroCadastroState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return switch (state) {
                                      RegistroInitial() =>
                                        const SizedBox.shrink(),
                                      RegistroInfo() => const SizedBox.shrink(),
                                      RegistroLoading() => const Padding(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 240, bottom: 0),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      RegistroLoaded() =>
                                        const SizedBox.shrink(),
                                    };
                                  },
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Center(child: Text('Salvar')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum TipoEntrada { entrada, saida, vazio }
