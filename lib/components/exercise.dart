import 'package:flutter/material.dart';

class Exercise extends StatelessWidget {
  final String exerciseName;
  final String advancedTechnique;
  final int repetitions;
  final int sets;

  const Exercise({
    super.key,
    this.exerciseName = 'Exercício X',
    this.repetitions = 0,
    this.sets = 0,
    this.advancedTechnique = 'nome aqui',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[100],
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      exerciseName,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(children: [
                            const Text(
                              'Repetições: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('$repetitions'),
                          ]),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(children: [
                            const Text(
                              'Séries: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('$sets'),
                          ]),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                    ]),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 60.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Téc. Avançanda: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(advancedTechnique),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
