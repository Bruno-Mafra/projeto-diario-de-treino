import "package:projeto_diario_de_treino/entities/execucao.dart";

class Exercicio {
  Exercicio({
    required this.nome,
    required this.quantidadeSeries,
    required this.tecnicaAvancada,
  });
  
  String nome;
  int quantidadeSeries;
  String tecnicaAvancada;
  List<Execucao> execucoes = [];
  
  void executarExercicio(){}
}