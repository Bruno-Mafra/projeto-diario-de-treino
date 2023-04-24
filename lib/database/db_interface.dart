import 'mongodb.dart';
import 'sqldb.dart';
import "package:projeto_diario_de_treino/entities/treino.dart";
import "package:projeto_diario_de_treino/entities/aluno.dart";
import 'package:projeto_diario_de_treino/entities/professor.dart';
import "package:mongo_dart/mongo_dart.dart";

class DbInterface {
  connect() async {
    await MongoDatabase.connect();
    await SQLDatabase.connect();
  }

  Future<void> inserirCadastro(Map<String, dynamic> novoCadastro) async {
    await SQLDatabase.db.query('''
    INSERT INTO dadoscadastrais (email, nome, senha, tipo_usuario) 
    VALUES (@email, @nome, @senha, @tipo_usuario)
    ''', substitutionValues: {
      'email': novoCadastro['email'],
      'nome': novoCadastro['nome'],
      'senha': novoCadastro['senha'],
      'tipo_usuario': novoCadastro['tipo_usuario']
    });
  }

  Future<void> inserirAluno(Map<String, dynamic> novoAluno) async {
    await SQLDatabase.db.query('''
    INSERT INTO alunos (email, altura, imc, peso, cref_professor) 
    VALUES (@email, @altura, @imc, @peso, @cref_professor)
    ''', substitutionValues: {
      'email': novoAluno['email'],
      'altura': novoAluno['altura'],
      'imc': novoAluno['imc'],
      'peso': novoAluno['peso'],
      'cref_professor': novoAluno['cref_professor']
    });
  }

  Future<void> inserirProfessor(Map<String, String> novoProfessor) async {
    await SQLDatabase.db.query('''
    INSERT INTO professor (cref, email)
    VALUES (@cref, @email)
    ''', substitutionValues: {
      'cref': novoProfessor['cref'],
      'email': novoProfessor['email'],
    });
  }

  Future<List<Aluno>> buscarAlunos(String cref) async {
    List<List<dynamic>> resultsAlunos = await SQLDatabase.db.query('''
    SELECT id_aluno, email FROM alunos
    WHERE cref_professor = @crefValue
    ''', substitutionValues: {
      "crefValue": cref
    });

    if(resultsAlunos.isNotEmpty) {
      List<Aluno> listaAlunos = [];
      for(List<dynamic> r in resultsAlunos){
        Map<String, dynamic> alunoInfo = await _alunoJson(r[1]);
        Aluno alunoObj = Aluno.fromJson(alunoInfo);
        alunoObj = await recuperarInfoAluno(alunoObj.email);
        listaAlunos.add(alunoObj);
      }

      return listaAlunos;
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> _professorJson(String email) async {
    List<List<dynamic>> resultsCadastro = await SQLDatabase.db.query('''
      SELECT email, nome FROM dadoscadastrais
      WHERE email = @emailValue
    ''', substitutionValues: {
      "emailValue": email
    });
    List<List<dynamic>> resultsProf = await SQLDatabase.db.query('''
      SELECT email, cref from professor 
      WHERE email = @emailValue
      ''', substitutionValues: {
      "emailValue": email
    });

    Map<String, dynamic> professorInfo = {
      "cref": resultsProf[0][1],
      "email": resultsCadastro[0][0],
      "nome": resultsCadastro[0][1],
    };

    return professorInfo;
  }

  Future<Map<String, dynamic>> _alunoJson(String email) async {
    List<List<dynamic>> resultsCadastro = await SQLDatabase.db.query('''
      SELECT email, nome FROM dadoscadastrais
      WHERE email = @emailValue
    ''', substitutionValues: {
      "emailValue": email
    });
    List<List<dynamic>> resultsAluno = await SQLDatabase.db.query('''
      SELECT id_aluno,email,altura,imc,peso,cref_professor from alunos 
      WHERE email = @emailValue
      ''', substitutionValues: {
      "emailValue": email
    });

    Map<String, dynamic> alunoInfo = {
      "id": resultsAluno[0][0],
      "email": resultsAluno[0][1],
      "nome": resultsCadastro[0][1],
      "altura": resultsAluno[0][2],
      "imc": resultsAluno[0][3],
      "peso": resultsAluno[0][4],
      "crefProfessor": resultsAluno[0][5],
    };

    return alunoInfo;
  }

  Future<Aluno> recuperarInfoAluno(String email) async {
    Map<String, dynamic> alunoInfo = await _alunoJson(email);
    List<Treino> treinoData = await buscarTreinos(alunoInfo['id']);
    Aluno alunoObj = Aluno.fromJson(alunoInfo);
    alunoObj.listaTreinos = treinoData;

    return alunoObj;
  }

  Future<Professor> recuperarInfoProfessor(String email) async {
    Map<String, dynamic> professorJson = await _professorJson(email);
    Professor professorObj = Professor.fromJson(professorJson);

    List<Aluno> listaAlunos = await buscarAlunos(professorJson["cref"]);
    professorObj.alunosVinculados = listaAlunos;

    return professorObj;
  }

  Future<String> salvarTreino(int idAluno, Treino treino) async {
    if (treino.id != null) {
      // modifica treino
      return " ";
    } else {
      try {
        treino.id = ObjectId();
        Map<String, dynamic> treinoJson = treino.toJson();
        treinoJson['idAluno'] = idAluno;
        var result = await MongoDatabase.collecTreinos.insertOne(treinoJson);
        if (result.isSucess){
          return "Data Inserted. Id: ${treino.id}";
        } else {
          return "Error";
        }
      } catch(e) {
        print(e.toString());
        return e.toString();
      }
    }
  }

  Future<List<Treino>> buscarTreinos(int idAluno) async {
    List<dynamic> treinoMongoData = await MongoDatabase.collecTreinos
        .find({"id_aluno": idAluno})
        .toList();

    List<Treino> listaTreinos = [];
    for(var treinoJson in treinoMongoData) {
      listaTreinos.add(Treino.fromJson(treinoJson));
    };
    return listaTreinos;
  }

  Future<int> checarUsuario(String email, [String? senha]) async {
    if (senha != null){
      List<List<dynamic>> results = await SQLDatabase.db.query('''
      SELECT email, tipo_usuario from dadoscadastrais 
      WHERE email = @emailValue AND senha = @senhaValue
      ''', substitutionValues: {
        "emailValue": email,
        "senhaValue": senha
      });

      if(results.isNotEmpty){
        List<dynamic> dadosUsuario = results[0];
        int tipoUsuario = dadosUsuario[1];
        return tipoUsuario;
      } else {
        return -1;
      }
    } else {
      List<List<dynamic>> results = await SQLDatabase.db.query(
          "SELECT email FROM dadoscadastrais WHERE email = @emailValue",
          substitutionValues: {
            "emailValue": email
          }
      );

      if(results.isNotEmpty){
        return 2;
      } else {
        return -1;
      }
    }
  }

  Future<void> buscarExercicios() async {}
}