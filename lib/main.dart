import 'package:flutter/material.dart';
import 'screens/student_workouts.dart';
import 'screens/professor_home.dart';
import 'screens/search_student.dart';
import 'screens/register.dart';
import 'screens/login.dart';

//Required imports for firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
      routes: {
        "/login": (context) => const LoginScreen(title: 'Diário de Treino'),
        "/register": (context) => const RegisterScreen(),
        "/student_home": (context) => const StudentWorkoutsScreen(),
        "/professor_home": (context) => const ProfessorHomeScreen(),
        "/search_student": (context) => const SearchStudentScreen(),
      },
    );
  }
}
