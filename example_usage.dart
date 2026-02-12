/*
 * Example of how to use the CustomComboBox in another Flutter project
 * 
 * To use this widget in your own project:
 * 1. Copy the custom_combobox.dart file to your lib/ directory (or lib/widgets/ directory)
 * 2. Import it in your Dart files: import 'package:your_app/custom_combobox.dart';
 *    (adjust the path according to where you placed the file)
 * 3. Use it as shown in the examples below
 */

// In your Flutter project, you would import the widget like this:
// import 'package:flutter/material.dart';
// import 'package:your_app/custom_combobox.dart'; // Adjust path as needed

/*
void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomComboBox Usage Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

// Simple string example
class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  String? _selectedValue;
  final List<String> _fruits = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomComboBox Usage Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Generic ComboBox Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomComboBox<String>(
              items: _fruits,
              itemToString: (fruit) => fruit,
              value: _selectedValue,
              hintText: 'Select a fruit...',
              onChanged: (fruit) {
                setState(() {
                  _selectedValue = fruit;
                });
                if (fruit != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $fruit')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            if (_selectedValue != null)
              Text('Selected: $_selectedValue')
            else
              const Text('No selection made'),
          ],
        ),
      ),
    );
  }
}

// Example with custom objects
class Person {
  final int id;
  final String name;
  final String email;

  Person({required this.id, required this.name, required this.email});

  @override
  String toString() => name;
}

class ObjectExamplePage extends StatefulWidget {
  const ObjectExamplePage({super.key});

  @override
  State<ObjectExamplePage> createState() => _ObjectExamplePageState();
}

class _ObjectExamplePageState extends State<ObjectExamplePage> {
  Person? _selectedPerson;
  final List<Person> _people = [
    Person(id: 1, name: 'John Doe', email: 'john@example.com'),
    Person(id: 2, name: 'Jane Smith', email: 'jane@example.com'),
    Person(id: 3, name: 'Bob Johnson', email: 'bob@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomComboBox with Objects'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ComboBox with Custom Objects',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomComboBox<Person>(
              items: _people,
              itemToString: (person) => person.name,
              value: _selectedPerson,
              hintText: 'Select a person...',
              onChanged: (person) {
                setState(() {
                  _selectedPerson = person;
                });
                if (person != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${person.name} (${person.email})')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            if (_selectedPerson != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${_selectedPerson!.name}'),
                  Text('Email: ${_selectedPerson!.email}'),
                  Text('ID: ${_selectedPerson!.id.toString()}'),
                ],
              )
            else
              const Text('No selection made'),
          ],
        ),
      ),
    );
  }
}
*/