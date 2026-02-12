# Custom ComboBox Widget

A customizable, generic combobox widget with search functionality and keyboard navigation for Flutter projects.

This widget was enhanced using an AI model to improve its UI design and user experience. The project is open source and available for anyone to use, modify, and contribute to.

## Features

- Generic type support (works with any data type)
- Search/filter functionality
- Keyboard navigation (arrow keys, enter, escape)
- Customizable display text via `itemToString` function
- Support for initial values and placeholder text
- Responsive dropdown positioning
- Clean Material Design UI
- Modern color scheme and improved styling

## Installation

To use this widget in your Flutter project, simply copy the `custom_combobox.dart` file to your project's `lib` directory or create a `widgets` folder and place it there.

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'path/to/custom_combobox.dart'; // Adjust path as needed

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? _selectedValue;
  final List<String> _items = ['Apple', 'Banana', 'Cherry', 'Date'];

  @override
  Widget build(BuildContext context) {
    return CustomComboBox<String>(
      items: _items,
      itemToString: (item) => item,
      value: _selectedValue,
      hintText: 'Select a fruit...',
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
        print('Selected: $value');
      },
    );
  }
}
```

### Advanced Example with Custom Objects

```dart
class Person {
  final int id;
  final String name;
  
  Person({required this.id, required this.name});
}

class PersonSelector extends StatefulWidget {
  @override
  _PersonSelectorState createState() => _PersonSelectorState();
}

class _PersonSelectorState extends State<PersonSelector> {
  Person? _selectedPerson;
  final List<Person> _people = [
    Person(id: 1, name: 'John Doe'),
    Person(id: 2, name: 'Jane Smith'),
    Person(id: 3, name: 'Bob Johnson'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomComboBox<Person>(
      items: _people,
      itemToString: (person) => person.name,
      value: _selectedPerson,
      hintText: 'Select a person...',
      onChanged: (person) {
        setState(() {
          _selectedPerson = person;
        });
        if (person != null) {
          print('Selected: ${person.name} (ID: ${person.id})');
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

## Keyboard Navigation

- Arrow Up/Down: Navigate through the dropdown items
- Enter/Space: Select the highlighted item
- Escape: Close the dropdown

## Customization

The widget follows Material Design guidelines and adapts to your app's theme. You can customize the appearance by wrapping the widget with other widgets or modifying the theme in your app.

## Contributing

This project is completely open source and welcomes contributions from anyone interested in improving it. Feel free to submit issues, fork the repository, or submit pull requests if you find any problems or have suggestions for improvements. Since this widget was enhanced using an AI model, we encourage collaborative development and welcome ideas from developers of all experience levels.