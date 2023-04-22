import 'dart:ffi';
import 'mongodb.dart';
import 'sqldb.dart';

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

  Future<void> buscarAlunos() async {}

  Future<void> recuperarInfoAluno(String email) async {}

  Future<void> recuperarInfoProfessor(String email) async {}

  Future<void> buscarTreinos() async {}

  Future<void> buscarExercicios() async {}

  Future<bool> checarUsuario(String email, [String? senha]) async {
    if (senha != null){
      List<List<dynamic>> results = await SQLDatabase.db.query('''
      SELECT email from dadoscadastrais 
      WHERE email = @emailValue AND senha = @senhaValue
      ''', substitutionValues: {
        "emailValue": email,
        "senhaValue": senha
      });

      if(results.isNotEmpty){
        return true;
      } else {
        return false;
      }
    } else {
      List<List<dynamic>> results = await SQLDatabase.db.query(
          "SELECT email FROM dadoscadastrais WHERE email = @emailValue",
          substitutionValues: {
            "emailValue": email
          }
      );

      if(results.isNotEmpty){
        return true;
      } else {
        return false;
      }
    }
  }
}