import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/exercise.dart';
import '../entities/aluno.dart';

class StudentWorkoutsScreen extends StatefulWidget {
  const StudentWorkoutsScreen(
      {super.key, required this.aluno, required this.isProfessorAccessing});

  final Aluno aluno;
  final bool isProfessorAccessing;

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
            Header(
                title: widget.isProfessorAccessing
                    ? 'Treinos do(a): ${widget.aluno.nome.split(" ")[0]}!'
                    : 'Olá, ${widget.aluno.nome.split(" ")[0]}!',
                showBackButton: widget.isProfessorAccessing),
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
            const Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                'Selecione um treino para acompanhar ou agendar.',
                style: TextStyle(
                  fontSize: 14,
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
                    itemCount: widget.aluno.listaTreinos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 != 0
                            ? Colors.grey[300]
                            : Colors.grey[100],
                        child: ExpansionTile(
                          iconColor: Colors.black,
                          leading: const Icon(Icons.fitness_center_outlined),
                          backgroundColor: Colors.red[400],
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.aluno.listaTreinos[index].nome),
                              IconButton(
                                onPressed: () {
                                  // Levaria para as funcionalidades de calendário
                                },
                                icon: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                          children: [
                            Column(
                              children: widget
                                  .aluno.listaTreinos[index].listaExercicios
                                  .map((exercicio) => Exercise(
                                        exerciseName: exercicio.nome,
                                        sets: exercicio.quantidadeSeries,
                                        repetitions:
                                            exercicio.quantidadeRepeticoes,
                                        advancedTechnique:
                                            exercicio.tecnicaAvancada,
                                      ))
                                  .toList(),
                            ),
                            Container(
                              height: 45,
                              color: Colors.white,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 70),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed('/edit_workout', arguments: {
                                      'aluno': widget.aluno,
                                      'workoutIndex': index
                                    });
                                  },
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
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                        '/edit_workout',
                        arguments: {'aluno': widget.aluno, 'workoutIndex': -1});
                  },
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
            const SizedBox(height: 25.0),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Text(
                'Quer melhorar seus treinos? Acompanhe seu progresso e faça ajustes para avançar a cada dia.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
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
