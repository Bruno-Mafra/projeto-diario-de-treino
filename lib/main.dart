import 'package:flutter/material.dart';
import '/screens/login.dart';

//Required imports for firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Future<void> main() async {
//  await Firebase.initializeApp(
//      options: DefaultFirebaseOptions.currentPlatform,
//  );
//
//  runApp(const MyApp());
//}

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
      home: const LogginScreen(title: 'Diário de Treino'),
    );
  }
}
