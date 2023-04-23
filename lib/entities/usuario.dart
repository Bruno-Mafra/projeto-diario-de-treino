import "package:projeto_diario_de_treino/database/db_interface.dart";
class Usuario {
  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipoUsuario,
  });

  String nome;
  String email;
  String senha;
  int tipoUsuario;

  Future<bool> checarExistencia() async {
    DbInterface interface = DbInterface();
    await interface.connect();

    bool usuarioExiste = await interface.checarUsuario(email);

    return usuarioExiste;
  }

  Future<String> cadastrar() async {
    bool usuarioExiste = await checarExistencia();
    if(usuarioExiste) {
      return "email_cadastrado";
    } else {
      DbInterface interface = DbInterface();
      await interface.connect();

      Map<String, dynamic> novoCadastro = {
        "email": email,
        "nome": nome,
        "senha": senha,
        "tipo_usuario": tipoUsuario
      };
      try {
        var resultado = await interface.inserirCadastro(novoCadastro);
        return "sucesso";
      } catch(e){
        print(e.toString());
        return "erro";
      }
    }
  }
}
