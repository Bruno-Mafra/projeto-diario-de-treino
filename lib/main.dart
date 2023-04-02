import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LogginScreen(title: 'Diário de Treino'),
    );
  }
}

class LogginScreen extends StatefulWidget {
  const LogginScreen({super.key, required this.title});

  final String title;

  @override
  _LogginScreenState createState() => _LogginScreenState();
}

class _LogginScreenState extends State<LogginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _obscureSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
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
            SizedBox(height: 16.0),
            TextField(
              controller: _senhaController,
              obscureText: _obscureSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                labelStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureSenha = !_obscureSenha;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text(
                'Entrar',                     
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return states.contains(MaterialState.pressed)
                      ? Colors.red[600]!
                      : Colors.red;
                  },
                ),
              ),
              onPressed: () {
                // verificar se o login esta correto no banco e ir para pagina inicial, se não, mostrar um toast de erro
              },
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ainda não é usuário? ',
                ),
                GestureDetector(
                  onTap: () {
                    // levar para tela de cadastro
                  },
                  child: Text(
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




