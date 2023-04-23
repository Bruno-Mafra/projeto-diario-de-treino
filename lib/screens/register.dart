// ignore_for_file: unused_import, library_private_types_in_public_api
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projeto_diario_de_treino/database/db_interface.dart';
import 'package:projeto_diario_de_treino/utils/tools.dart';
import 'package:projeto_diario_de_treino/entities/usuario.dart';
import "package:projeto_diario_de_treino/entities/aluno.dart";
import "package:projeto_diario_de_treino/entities/professor.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatedController = TextEditingController();

  bool _isLoading = false;
  bool _isAlunoSelected = true;
  bool _isProfessorSelected = false;

  bool _obscurePassword = true;
  bool _obscurePasswordRepeated = true;

  void _handleAlunoSelected(bool? value) {
    setState(() {
      _isAlunoSelected = value ?? false;
      _isProfessorSelected = value == null ? false : !value;
    });
  }

  void _handleProfessorSelected(bool? value) {
    setState(() {
      _isProfessorSelected = value ?? false;
      _isAlunoSelected = value == null ? false : !value;
    });
  }

  void _handleFormSubmit() async {
    String toastMessage = '';

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _passwordRepeatedController.text.isEmpty) {
      toastMessage = 'Existem campos não preenchidos!';
    }

    if (_passwordController.text != _passwordRepeatedController.text) {
      toastMessage = 'As senhas digitadas não coincidem!';
    }

    if (toastMessage.isNotEmpty) {
      Fluttertoast.showToast(
          msg: toastMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 14.0);
    } else {
      setState(() {
        _isLoading = true;
      });

      try {
        if (_isAlunoSelected) {
          Aluno novoAluno = Aluno(
            email: _emailController.text,
            nome: _nameController.text,
            senha: _passwordController.text,
          );
          String resultado = await novoAluno.cadastrar();
          if (resultado == "sucesso") {
            Navigator.of(context, rootNavigator: true)
                .pushNamed('/student_home');
          } else if (resultado == "email_cadastrado") {
            print("Usuario existe.");
            Fluttertoast.showToast(
                msg: "O email inserido já está cadastrado.",
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
        } else {
          Professor novoProfessor = Professor(
              email: _emailController.text,
              nome: _nameController.text,
              senha: _passwordController.text,
              cref: generateRandomString(16));
          String resultado = await novoProfessor.cadastrar();
          if (resultado == "sucesso") {
            Navigator.of(context, rootNavigator: true)
                .pushNamed('/professor_home');
          } else if (resultado == "email_cadastrado") {
            print("Usuario existe.");
            Fluttertoast.showToast(
                msg: "O email inserido já está cadastrado.",
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
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Cadastro'),
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Preencha seus dados: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
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
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordRepeatedController,
                      obscureText: _obscurePasswordRepeated,
                      decoration: InputDecoration(
                        labelText: 'Confirme a senha',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePasswordRepeated
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePasswordRepeated =
                                  !_obscurePasswordRepeated;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Quero usar o aplicativo como: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: true,
                                groupValue: _isAlunoSelected,
                                onChanged: _handleAlunoSelected,
                                activeColor: Colors.red,
                              ),
                              const Text(
                                'Aluno',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: true,
                                groupValue: _isProfessorSelected,
                                onChanged: _handleProfessorSelected,
                                activeColor: Colors.red,
                              ),
                              const Text(
                                'Professor',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      // width: 2 * (MediaQuery.of(context).size.width) / 3,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleFormSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Concluir',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
