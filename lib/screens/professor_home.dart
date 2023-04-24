import 'package:flutter/material.dart';
import '../components/header.dart';
import '../entities/professor.dart';

class ProfessorHomeScreen extends StatefulWidget {
  const ProfessorHomeScreen({Key? key, required this.professor})
      : super(key: key);

  final Professor professor;

  @override
  _ProfessorHomeScreenState createState() => _ProfessorHomeScreenState();
}

class _ProfessorHomeScreenState extends State<ProfessorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
                title: 'Olá, professor ${widget.professor.nome.split(" ")[0]}!',
                showBackButton: false),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Seus alunos vinculados:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Selecione um aluno para acompanhar seu progresso.',
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
                    itemCount: widget.professor.alunosVinculados.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/student_home', arguments: {
                            'aluno': widget.professor.alunosVinculados[index],
                            'isProfessorAccessing': true,
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: index % 2 != 0
                                ? Colors.grey[300]
                                : Colors.grey[100],
                          ),
                          height: 50,
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey[400],
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.professor.alunosVinculados[index].nome,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
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
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/search_student');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Vincular novo aluno',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
