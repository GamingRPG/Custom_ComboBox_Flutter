# Custom ComboBox Widget

A custom Flutter combobox widget with search functionality and keyboard navigation support.

## Features

- **Searchable**: Type to filter the dropdown list
- **Keyboard Navigation**: Use up/down arrow keys to navigate through the list
- **Enter/Space**: Select the highlighted item
- **Escape**: Close the dropdown
- **Responsive Design**: Adapts to different screen sizes
- **Generic Support**: Works with any data type

## Installation

To use this widget in your Flutter project, copy the `custom_combobox.dart` file to your project's lib directory.

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'custom_combobox.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? _selectedValue;
  final List<String> _items = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomComboBox<String>(
          items: _items,
          itemToString: (item) => item,
          value: _selectedValue,
          hintText: 'Select a fruit...',
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
      ),
    );
  }
}
```

### Advanced Example with Custom Objects

```dart
class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  String toString() => '$name ($age)';
}

class PersonSelector extends StatefulWidget {
  @override
  _PersonSelectorState createState() => _PersonSelectorState();
}

class _PersonSelectorState extends State<PersonSelector> {
  Person? _selectedPerson;
  final List<Person> _people = [
    Person('John Doe', 30),
    Person('Jane Smith', 25),
    Person('Bob Johnson', 45),
    Person('Alice Williams', 35),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomComboBox<Person>(
      items: _people,
      itemToString: (person) => '${person.name} (${person.age})',
      value: _selectedPerson,
      hintText: 'Select a person...',
      onChanged: (person) {
        setState(() {
          _selectedPerson = person;
        });
      },
    );
  }
}
```

### Database Records Example (ID and Name)

For database records with separate ID and name fields:

```dart
class DatabaseRecord {
  final int id;
  final String name;

  DatabaseRecord({required this.id, required this.name});
}

class DatabaseComboBox extends StatefulWidget {
  @override
  _DatabaseComboBoxState createState() => _DatabaseComboBoxState();
}

class _DatabaseComboBoxState extends State<DatabaseComboBox> {
  DatabaseRecord? _selectedRecord;
  final List<DatabaseRecord> _records = [
    DatabaseRecord(id: 1, name: 'Apple'),
    DatabaseRecord(id: 2, name: 'Banana'),
    DatabaseRecord(id: 3, name: 'Cherry'),
    // ... more records
  ];

  @override
  Widget build(BuildContext context) {
    return CustomComboBox<DatabaseRecord>(
      items: _records,
      itemToString: (record) => record.name,  // Show the name field
      value: _selectedRecord,
      hintText: 'Select an item...',
      onChanged: (record) {
        setState(() {
          _selectedRecord = record;
        });
        if (record != null) {
          // Use the ID for database operations
          print('Selected ID: ${record.id}, Name: ${record.name}');
        }
      },
    );
  }
}
```

## Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `items` | `List<T>` | List of items to display in the dropdown |
| `itemToString` | `String Function(T)` | Function to get the display text for each item |
| `onChanged` | `void Function(T?)?` | Callback when an item is selected |
| `hintText` | `String?` | Placeholder text for the search field |
| `value` | `T?` | Current selected value |
| `maxHeight` | `double` | Maximum height of the dropdown (default: 300) |
| `enabled` | `bool` | Whether the combobox is enabled (default: true) |

## Functionality

### Search
As you type in the combobox, the dropdown list will automatically filter to show only matching items.

### Keyboard Navigation
- **Up Arrow**: Navigate to the previous item in the list (works even while typing)
- **Down Arrow**: Navigate to the next item in the list (works even while typing)
- **Enter/Space**: Select the currently highlighted item
- **Escape**: Close the dropdown without selecting an item

### Mouse/Touch Interaction
- Click on the dropdown icon to open/close the list
- Click on any item in the list to select it
- Click outside the dropdown to close it

## Customization

The widget uses standard Flutter themes and will adapt to your app's theme. You can customize the appearance by wrapping the widget with other widgets or by modifying the source code.

## Notes

- The widget handles focus management automatically
- The dropdown position is calculated to stay within screen bounds
- The search is case-insensitive
- The widget supports null values for the selected item# Custom_ComboBox_Flutter
