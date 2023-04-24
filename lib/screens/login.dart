import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projeto_diario_de_treino/database/db_interface.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  void _validateLogin() async {
    setState(() {
      _isLoading = true;
    });

    DbInterface interface = DbInterface();
    await interface.connect();
    interface
        .checarUsuario(_emailController.text, _passwordController.text)
        .then((autenticado) {
      if (autenticado == 0) {
        interface.recuperarInfoAluno(_emailController.text).then((aluno) => {
              Navigator.of(context, rootNavigator: true).pushNamed(
                  '/student_home',
                  arguments: {'aluno': aluno, 'isProfessorAccessing': false})
            });
      } else if (autenticado == 1) {
        interface
            .recuperarInfoProfessor(_emailController.text)
            .then((professor) => {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      '/professor_home',
                      arguments: {'professor': professor})
                });
      } else {
        Fluttertoast.showToast(
            msg: "Usuário ou senha inválidos.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 14.0);

        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return states.contains(MaterialState.pressed)
                              ? Colors.red[600]!
                              : Colors.red;
                        },
                      ),
                    ),
                    onPressed: _validateLogin,
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Ainda não é usuário? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/register');
                        },
                        child: const Text(
                          'Fazer cadastro',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
