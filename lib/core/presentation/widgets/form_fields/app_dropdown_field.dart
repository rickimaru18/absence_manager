import 'package:flutter/material.dart';

import '../../../core.dart';

class AppDropdownField<T extends DropdownItem> extends StatelessWidget {
  const AppDropdownField({
    required this.onChanged,
    required this.items,
    required this.label,
    this.value,
    super.key,
  });

  final ValueChanged<T?> onChanged;
  final List<T> items;
  final String label;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(label),
        ),
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<T?>(
            onChanged: onChanged,
            value: value,
            items: <DropdownMenuItem<T?>>[
              DropdownMenuItem<T?>(
                child: const Text('-'),
              ),
              ...items.map(
                (T item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.dropdownText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
