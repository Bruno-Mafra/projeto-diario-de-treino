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

import '../entities/aluno.dart';
import "../entities/professor.dart";

Future<void> main() async {
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
      onGenerateRoute: (settings) {
        // Define as rotas que dependem de parâmetros aqui
        if (settings.name == "/student_home") {
          final args = settings.arguments as Map<String, dynamic>;
          final aluno = args["aluno"] as Aluno;
          final isProfessorAccessing = args["isProfessorAccessing"] as bool;
          return MaterialPageRoute(
            builder: (context) => StudentWorkoutsScreen(
              aluno: aluno,
              isProfessorAccessing: isProfessorAccessing,
            ),
          );
        } else if (settings.name == "/edit_workout") {
          final args = settings.arguments as Map<String, dynamic>;
          final aluno = args["aluno"] as Aluno;
          final index = args["workoutIndex"] as int;
          return MaterialPageRoute(
            builder: (context) =>
                EditWorkoutScreen(aluno: aluno, workoutIndex: index),
          );
        } else if (settings.name == "/professor_home") {
          final args = settings.arguments as Map<String, dynamic>;
          final professor = args["professor"] as Professor;
          return MaterialPageRoute(
            builder: (context) => ProfessorHomeScreen(professor: professor),
          );
        }
        // Caso contrário, use as rotas definidas no `routes`
        return null;
      },
      routes: {
        "/login": (context) => const LoginScreen(title: 'Diário de Treino'),
        "/register": (context) => const RegisterScreen(),
        "/search_student": (context) => const SearchStudentScreen(),
      },
    );
  }
}
