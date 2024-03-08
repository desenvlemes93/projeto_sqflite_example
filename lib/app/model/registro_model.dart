import 'dart:convert';
class RegistroModel {
  final String nome;
  final DateTime data;
  final String hora;
  final String tipoEntrada;
  RegistroModel({
    required this.nome,
    required this.data,
    required this.hora,
    required this.tipoEntrada,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'descricao': nome,
      'datainicial': data,
      'hora': hora,
      'tipoEntrada': tipoEntrada,
    };
  }

  factory RegistroModel.fromMap(Map<String, dynamic> map) {
    return RegistroModel(
      nome: map['descricao'] ?? '',
      data: DateTime.parse(map['datainicial']),
      hora: map['hora'] ?? '',
      tipoEntrada: map['tipoEntrada'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistroModel.fromJson(String source) =>
      RegistroModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegistroModel(nome: $nome, data: $data, hora: $hora, tipoEntrada: $tipoEntrada)';
  }
}