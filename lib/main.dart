import 'package:flutter/material.dart';
import 'screens/edit_workout.dart';
import 'screens/student_workouts.dart';
import 'screens/professor_home.dart';
import 'screens/search_student.dart';
import 'screens/register.dart';
import 'screens/login.dart';

//Required imports for firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import "package:projeto_diario_de_treino/database/db_interface.dart";
import 'package:projeto_diario_de_treino/entities/aluno.dart';
import "package:projeto_diario_de_treino/entities/professor.dart";

Future<void> main() async {
  DbInterface interface = DbInterface();
  await interface.connect();

  Professor novoProfessor = await interface.recuperarInfoProfessor("professor_a@gmail.com");
  print("FUNCIONOU 1!");
  print(novoProfessor.nome);
  print(novoProfessor.alunosVinculados);
  print(novoProfessor.alunosVinculados[0].nome);
  
  Aluno novoAluno = await interface.recuperarInfoAluno("whatever@gmail.com");
  print("FUNCIONOU 2!");
  print(novoAluno.nome);
  print(novoAluno.listaTreinos.toString());
  print(novoAluno.listaTreinos[0].nome);

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } finally {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginScreen(title: 'Diário de Treino'),
        "/register": (context) => const RegisterScreen(),
        "/student_home": (context) => const StudentWorkoutsScreen(),
        "/professor_home": (context) => const ProfessorHomeScreen(),
        "/search_student": (context) => const SearchStudentScreen(),
        "/edit_workout": (context) => const EditWorkoutScreen(),
      },
    );
  }
}
