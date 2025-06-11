import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FirstScreen());
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  bool _agree = false;

  void _submit() {
    if (_formKey.currentState!.validate() && _agree) {
      double a = double.parse(_aController.text);
      double b = double.parse(_bController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(a: a, b: b),
        ),
      );
    } else if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Необходимо согласие на обработку данных'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бакшеев Олег Евгеньевич')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _aController,
                decoration: const InputDecoration(labelText: 'Число a'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите число a';
                  if (double.tryParse(value) == null)
                    return 'Введите корректное число';
                  return null;
                },
              ),
              TextFormField(
                controller: _bController,
                decoration: const InputDecoration(labelText: 'Число b'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите число b';
                  if (double.tryParse(value) == null)
                    return 'Введите корректное число';
                  return null;
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (val) {
                      setState(() {
                        _agree = val ?? false;
                      });
                    },
                  ),
                  const Text('Согласен на обработку данных'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double a;
  final double b;

  const ResultScreen({super.key, required this.a, required this.b});

  @override
  Widget build(BuildContext context) {
    double result = (a + b) * (a + b) * (a + b); // (a + b)^3

    return Scaffold(
      appBar: AppBar(title: const Text('Результат')),
      body: Center(
        child: Text(
          '($a + $b)^3 = $result',
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
