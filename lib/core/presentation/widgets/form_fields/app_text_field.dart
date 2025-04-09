import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.onTap,
    this.controller,
    this.suffixIcon,
    required this.label,
    this.readOnly = false,
    super.key,
  });

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String label;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(label),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            onTap: onTap,
            controller: controller,
            readOnly: readOnly,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
