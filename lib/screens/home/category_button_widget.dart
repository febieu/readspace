import 'package:flutter/material.dart';

class CategoryButtonWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButtonWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        backgroundColor:
        isSelected ? Color.fromARGB(25, 33, 150, 243) : Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
