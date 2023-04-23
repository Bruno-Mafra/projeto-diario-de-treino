import 'package:flutter/material.dart';

class ExercisesModal extends StatefulWidget {
  const ExercisesModal({Key? key}) : super(key: key);

  @override
  _ExercisesModalState createState() => _ExercisesModalState();
}

class _ExercisesModalState extends State<ExercisesModal> {
  String _selectedOption = '';

  void _onOptionSelected(String? option) {
    setState(() {
      _selectedOption = option ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Selecione um tipo de exercício',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Flexão'),
            trailing: Radio<String>(
              value: 'Opção 1',
              groupValue: _selectedOption,
              onChanged: _onOptionSelected,
            ),
          ),
          ListTile(
            title: const Text('Agachamento'),
            trailing: Radio<String>(
              value: 'Opção 2',
              groupValue: _selectedOption,
              onChanged: _onOptionSelected,
            ),
          ),
          ListTile(
            title: const Text('Abdominal'),
            trailing: Radio<String>(
              value: 'Opção 3',
              groupValue: _selectedOption,
              onChanged: _onOptionSelected,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Adicionar',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
