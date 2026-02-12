import 'package:flutter/material.dart';
import 'custom_combobox.dart';

/// Example showing how to use the CustomComboBox with basic string values
class BasicExample extends StatefulWidget {
  const BasicExample({super.key});

  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
  String? _selectedValue;
  final List<String> _items = [
    'Apple', 'Apricot', 'Avocado', 'Banana', 'Blackberry', 'Blueberry',
    'Cherry', 'Coconut', 'Cranberry', 'Date', 'Dragonfruit', 'Durian',
    'Elderberry', 'Feijoa', 'Fig', 'Gooseberry', 'Grape', 'Grapefruit',
    'Guava', 'Honeydew', 'Jackfruit', 'Jujube', 'Kiwi', 'Kumquat',
    'Lemon', 'Lime', 'Lychee', 'Mango', 'Melon', 'Mulberry',
    'Nectarine', 'Orange', 'Papaya', 'Passionfruit', 'Peach', 'Pear',
    'Persimmon', 'Pineapple', 'Plum', 'Pomegranate', 'Quince', 'Raspberry',
    'Redcurrant', 'Satsuma', 'Strawberry', 'Tamarillo', 'Tangerine',
    'Ugli fruit', 'Watermelon', 'Xigua', 'Yellow watermelon', 'Zucchini'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Basic ComboBox Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom ComboBox with Search and Keyboard Navigation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomComboBox<String>(
              items: _items,
              itemToString: (item) => item,
              value: _selectedValue,
              hintText: 'Select a fruit...',
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
                if (value != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $value')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            if (_selectedValue != null)
              Text('Selected Value: $_selectedValue')
            else
              const Text('No value selected'),
          ],
        ),
      ),
    );
  }
}

/// Example showing how to use the CustomComboBox with custom objects
class DatabaseExample extends StatefulWidget {
  const DatabaseExample({super.key});

  @override
  State<DatabaseExample> createState() => _DatabaseExampleState();
}

// Example class representing a database record with id and name
class DatabaseRecord {
  final int id;
  final String name;

  DatabaseRecord({required this.id, required this.name});

  @override
  String toString() => name; // This allows using the name for display by default
}

class _DatabaseExampleState extends State<DatabaseExample> {
  DatabaseRecord? _selectedRecord;

  // Simulating data that would come from a database
  final List<DatabaseRecord> _databaseRecords = [
    DatabaseRecord(id: 1, name: 'Apple'),
    DatabaseRecord(id: 2, name: 'Banana'),
    DatabaseRecord(id: 3, name: 'Cherry'),
    DatabaseRecord(id: 4, name: 'Date'),
    DatabaseRecord(id: 5, name: 'Elderberry'),
    DatabaseRecord(id: 6, name: 'Fig'),
    DatabaseRecord(id: 7, name: 'Grape'),
    DatabaseRecord(id: 8, name: 'Honeydew'),
    DatabaseRecord(id: 9, name: 'Kiwi'),
    DatabaseRecord(id: 10, name: 'Lemon'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Database ComboBox Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ComboBox with Database Records (ID and Name)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomComboBox<DatabaseRecord>(
              items: _databaseRecords,
              itemToString: (record) => record.name, // Display the name field
              value: _selectedRecord,
              hintText: 'Select a fruit...',
              onChanged: (record) {
                setState(() {
                  _selectedRecord = record;
                });
                if (record != null) {
                  // Here you would typically use the ID for database operations
                  print('Selected ID: ${record.id}, Name: ${record.name}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected ID: ${record.id}, Name: ${record.name}')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            if (_selectedRecord != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Record:'),
                  Text('ID: ${_selectedRecord!.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Name: ${_selectedRecord!.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            else
              const Text('No record selected'),
          ],
        ),
      ),
    );
  }
}