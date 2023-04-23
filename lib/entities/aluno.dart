import "package:projeto_diario_de_treino/entities/usuario.dart";
import "package:projeto_diario_de_treino/entities/treino.dart";
import "package:projeto_diario_de_treino/database/db_interface.dart";

class Aluno extends Usuario {
  Aluno({
    required String email,
    required String nome,
    required String senha,
    this.altura,
    this.imc,
    this.peso,
    this.crefProfesor,
  }) : super(nome: nome, email: email, senha: senha, tipoUsuario: 0);

  double? altura;
  double? imc;
  double? peso;
  List<Treino> listaTreinos = [];
  String? crefProfesor;

  void adicionarTreino() {}
  void removerTreino() {}
  void selecionarTreino() {}
  void listarTreinos() {}
  void extrairProgressao() {}
  Future<void> sync() async {}

  Map<String, dynamic> toJson() => {
    "email": email,
    "altura": altura,
    "imc": imc,
    "peso": peso,
    "cref_professor": crefProfesor,
  };

  factory Aluno.fromJson(Map<String, dynamic> dbInfo) => Aluno(
    email: dbInfo['email'],
    nome: dbInfo['nome'],
    senha: "",
    altura: dbInfo['altura'],
    imc: dbInfo['imc'],
    peso: dbInfo['peso'],
    crefProfesor: dbInfo['crefProfessor']
  );

  @override
  Future<String> cadastrar() async {
    String resultado = await super.cadastrar();

    if(resultado == "sucesso"){
        DbInterface interface = DbInterface();
        await interface.connect();
        try {
          await interface.inserirAluno(toJson());
        } catch(e) {
          print(e.toString());
          resultado = "erro";
        }
    }

    return resultado;
  }
}