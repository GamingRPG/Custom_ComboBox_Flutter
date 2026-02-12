import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A custom combobox widget with search functionality and keyboard navigation
class CustomComboBox<T> extends StatefulWidget {
  /// List of items to display in the dropdown
  final List<T> items;
  
  /// Function to get the display text for each item
  final String Function(T) itemToString;
  
  /// Callback when an item is selected
  final void Function(T?)? onChanged;
  
  /// Placeholder text for the search field
  final String? hintText;
  
  /// Current selected value
  final T? value;
  
  /// Maximum height of the dropdown
  final double maxHeight;
  
  /// Whether the combobox is enabled
  final bool enabled;

  const CustomComboBox({
    super.key,
    required this.items,
    required this.itemToString,
    this.onChanged,
    this.hintText,
    this.value,
    this.maxHeight = 300,
    this.enabled = true,
  });

  @override
  State<CustomComboBox<T>> createState() => _CustomComboBoxState<T>();
}

class _CustomComboBoxState<T> extends State<CustomComboBox<T>> with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  
  bool _isDropdownVisible = false;
  List<T> _filteredItems = [];
  int _selectedIndex = -1;
  late String _currentText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize with current value if exists
    if (widget.value != null) {
      _currentText = widget.itemToString(widget.value as T);
      _textController.text = _currentText;
    } else {
      _currentText = '';
    }
    
    _filteredItems = List.from(widget.items);
    
    _focusNode.addListener(_handleFocusChange);
    // Listen to keyboard events on the focus node
    _focusNode.onKeyEvent = _handleKeyDownEvent;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _textController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomComboBox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update filtered items when the items list changes
    if (oldWidget.items != widget.items) {
      _filteredItems = List.from(widget.items);
      _filterItems(_textController.text);
    }
    
    // Update text when value changes externally
    if (oldWidget.value != widget.value && widget.value != null) {
      _currentText = widget.itemToString(widget.value as T);
      _textController.text = _currentText;
    }
  }

  @override
  void didChangeMetrics() {
    // Rebuild when screen metrics change (e.g., keyboard appears/disappears)
    if (_isDropdownVisible) {
      setState(() {});
    }
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _showDropdown();
    } else {
      // Delay hiding to allow for item selection
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!_focusNode.hasFocus) {
          _hideDropdown();
        }
      });
    }
  }

  KeyEventResult _handleKeyDownEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      _handleKeyDown(event);
    }
    return KeyEventResult.ignored;
  }

  void _showDropdown() {
    setState(() {
      _isDropdownVisible = true;
      _filterItems(_textController.text);
    });
  }

  void _hideDropdown() {
    setState(() {
      _isDropdownVisible = false;
      _selectedIndex = -1;
    });
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = List.from(widget.items);
        _selectedIndex = -1;
      });
    } else {
      setState(() {
        _filteredItems = widget.items
            .where((item) => widget.itemToString(item)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        _selectedIndex = _filteredItems.isNotEmpty ? 0 : -1;
      });
    }
  }

  void _selectItem(int index) {
    if (index >= 0 && index < _filteredItems.length) {
      T selectedItem = _filteredItems[index];
      String selectedText = widget.itemToString(selectedItem);
      
      setState(() {
        _currentText = selectedText;
        _textController.text = selectedText;
        _selectedIndex = -1;
      });
      
      widget.onChanged?.call(selectedItem);
      _hideDropdown();
    }
  }

  void _handleKeyDown(KeyEvent event) {
    if (!_isDropdownVisible) return;
    
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (_filteredItems.isNotEmpty) {
          _selectedIndex = (_selectedIndex + 1) % _filteredItems.length;
        }
      });
      return;
    }
    
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (_filteredItems.isNotEmpty) {
          _selectedIndex = _selectedIndex <= 0 
              ? _filteredItems.length - 1 
              : _selectedIndex - 1;
        }
      });
      return;
    }
    
    if (event.logicalKey == LogicalKeyboardKey.enter || 
        event.logicalKey == LogicalKeyboardKey.space) {
      if (_selectedIndex >= 0 && _selectedIndex < _filteredItems.length) {
        _selectItem(_selectedIndex);
      }
      return;
    }
    
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _hideDropdown();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            controller: _textController,
            focusNode: _focusNode,
            enabled: widget.enabled,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Select an option',
              suffixIcon: IconButton(
                icon: Icon(_isDropdownVisible 
                    ? Icons.arrow_drop_up 
                    : Icons.arrow_drop_down),
                onPressed: () {
                  if (_isDropdownVisible) {
                    _hideDropdown();
                  } else {
                    _showDropdown();
                  }
                },
              ),
            ),
            onChanged: (value) {
              _currentText = value;
              _filterItems(value);
            },
            onTap: () {
              _showDropdown();
            },
            onSubmitted: (value) {
              // Handle submission if needed
            },
          ),
        ),
        if (_isDropdownVisible)
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0.0, 50.0), // Position the dropdown below the input field
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: 300, // Match the width of the input field
                constraints: BoxConstraints(
                  maxHeight: widget.maxHeight,
                ),
                child: ListView.builder(
                  itemCount: _filteredItems.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(), // Prevent overscroll
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedIndex == index;
                    return InkWell(
                      onTap: () => _selectItem(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).highlightColor : Colors.transparent,
                        ),
                        child: Text(
                          widget.itemToString(_filteredItems[index]),
                          style: TextStyle(
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}