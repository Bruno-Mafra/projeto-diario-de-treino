import "package:projeto_diario_de_treino/entities/execucao.dart";

class Exercicio {
  Exercicio({
    required this.nome,
    required this.quantidadeSeries,
    required this.quantidadeRepeticoes,
    required this.tecnicaAvancada,
  });
  
  String nome;
  int quantidadeSeries;
  int quantidadeRepeticoes;
  String tecnicaAvancada;
  List<Execucao> execucoes = [];
  
  void executarExercicio(){}
}