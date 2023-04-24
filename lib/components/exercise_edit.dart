import 'package:flutter/material.dart';

class ExerciseEdit extends StatefulWidget {
  ExerciseEdit({
    super.key,
    this.sets = 3,
    this.repetitions = 15,
    this.advancedTechnique = 'Padrão',
  });

  int sets;
  int repetitions;
  String advancedTechnique;

  @override
  _ExerciseEditState createState() => _ExerciseEditState();
}

class _ExerciseEditState extends State<ExerciseEdit> {
  final _setsController = TextEditingController();
  final _repetitionsController = TextEditingController();
  final _advancedTechniqueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setsController.text = widget.sets.toString();
    _repetitionsController.text = widget.repetitions.toString();
    _advancedTechniqueController.text = widget.advancedTechnique;
  }

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
                    Row(
                      children: [
                        const Text('Séries: '),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Séries',
                              border: OutlineInputBorder(),
                            ),
                            controller: _setsController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('Repetições: '),
                        Expanded(
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Repetições',
                                border: OutlineInputBorder(),
                              ),
                              controller: _repetitionsController),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Técnica Avançada: '),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Descrição da técnica',
                              border: OutlineInputBorder(),
                            ),
                            controller: _advancedTechniqueController,
                          ),
                        ),
                      ],
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
