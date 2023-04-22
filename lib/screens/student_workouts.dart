import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/exercise.dart';

class StudentWorkoutsScreen extends StatefulWidget {
  const StudentWorkoutsScreen({super.key});

  @override
  _StudentWorkoutsScreenState createState() => _StudentWorkoutsScreenState();
}

class _StudentWorkoutsScreenState extends State<StudentWorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(title: 'Olá, Fulano!', showBackButton: false),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lista de Treinos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 325,
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 != 0
                            ? Colors.grey[300]
                            : Colors.grey[100],
                        child: ExpansionTile(
                          iconColor: Colors.black,
                          leading: const Icon(Icons.fitness_center_outlined),
                          backgroundColor: Colors.red[400],
                          title: Text('Treino ${index + 1}'),
                          children: [
                            const Exercise(),
                            const Exercise(),
                            const Exercise(),
                            Container(
                              height: 45,
                              color: Colors.white,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 70),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text(
                                    'Editar treino',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 55,
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Adicionar novo treino',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Algum texto pra colocar aqui depois: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Container(
              height: 60,
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Acompanhar progresso de treino',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
