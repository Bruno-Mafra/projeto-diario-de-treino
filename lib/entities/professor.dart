import "package:projeto_diario_de_treino/database/db_interface.dart";
import "package:projeto_diario_de_treino/entities/usuario.dart";
import "package:projeto_diario_de_treino/entities/aluno.dart";

class Professor extends Usuario {
  Professor({
    email,
    nome,
    senha,
    required this.cref,
  }) : super(nome: nome, email: email, senha: senha, tipoUsuario: 1);

  String cref;
  List<Aluno> alunosVinculados = [];

  void adicionarAluno(Aluno novoAluno) {}
  void removerAluno(Aluno novoAluno) {}
  void acessarDadosAluno(String nomeAluno) {}
  void listarAlunos() {}

  Map<String, String> toJson() => {
    "cref": cref,
    "email": email
  };

  @override
  Future<String> cadastrar() async {
    String resultado = await super.cadastrar();

    if(resultado == "sucesso"){
      DbInterface interface = DbInterface();
      await interface.connect();
      try {
        await interface.inserirProfessor(toJson());
      } catch(e) {
        print(e.toString());
        resultado = "erro";
      }
    }

    return resultado;
  }
}