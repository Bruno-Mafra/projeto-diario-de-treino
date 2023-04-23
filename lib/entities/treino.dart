import 'package:projeto_diario_de_treino/entities/exercicio.dart';
import "package:mongo_dart/mongo_dart.dart";
import "dart:convert";

class Treino {
  Treino(
      {required this.id,
      required this.nome,
      required this.listaExercicios,
      required this.agendamento,
      required this.numSemanasRecorrencia});

  ObjectId? id;
  String nome;
  List<Exercicio> listaExercicios;
  DateTime? agendamento;
  int? numSemanasRecorrencia;

  void adicionarExercicio(Exercicio novoExercicio) {
    listaExercicios.add(novoExercicio);
  }

  void removerExercicio(String nomeExercicio) {
    listaExercicios.removeWhere((Exercicio ex) => ex.nome == nomeExercicio);
  }

  void agendarExecucao(DateTime agendamento, [int? recorrencia]) {}

  void acessarInfoExercicio(String nomeExercicio) {}

  List<String>? listarExercicios() {
    return listaExercicios.map((Exercicio x) => x.nome).toList();
  }

  factory Treino.fromJson(Map<String, dynamic> json) => Treino(
        id: json["_id"],
        nome: json["nome"],
        listaExercicios: json["listaExercicios"].map<Exercicio>(
          (x) => Exercicio(
            nome: x["nome"],
            quantidadeRepeticoes: x["quantidadeRepeticoes"],
            quantidadeSeries: x["quantidadeSeries"],
            tecnicaAvancada: x["tecnicaAvancada"],
          ),
        ).toList(),
        agendamento: json["agendamento"],
        numSemanasRecorrencia: json["numSemanasRecorrencia"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nome": nome,
        "listaExercicios": listaExercicios.map((Exercicio x) => {
              "nome": x.nome,
              "quantidadeRepeticoes": x.quantidadeRepeticoes,
              "quantidadeSeries": x.quantidadeSeries,
              "tecnicaAvancada": x.tecnicaAvancada,
            }).toList(),
        "agendamento": agendamento,
        "numSemanasRecorrencia": numSemanasRecorrencia,
      };
}
