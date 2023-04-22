import 'package:flutter/material.dart';
import '../components/header.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  _SearchStudentScreenState createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  List<bool> checkboxValues = List.generate(5, (index) => false);

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(title: 'Diário de Treino', showBackButton: true),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Alunos ainda sem vínculo:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              child: TextFormField(
                controller: _searchController,
                onChanged: (value) => {},
                decoration: const InputDecoration(
                  labelText: 'Buscar aluno',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                'Selecione os alunos que deseja vincular a sua conta.',
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: index % 2 != 0
                              ? Colors.grey[300]
                              : Colors.grey[100],
                        ),
                        height: 50,
                        child: Center(
                          child: Row(children: [
                            Checkbox(
                                value: checkboxValues[index],
                                onChanged: (newValue) {
                                  setState(() {
                                    checkboxValues[index] = newValue!;
                                  });
                                }),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey[400],
                              child:
                                  Icon(Icons.person, color: Colors.grey[600]),
                            ),
                            const SizedBox(width: 8),
                            Text('Aluno ${index + 1}'),
                          ]),
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
                    'Vincular aluno(s)',
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
