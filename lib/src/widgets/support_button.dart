import 'package:flutter/material.dart';

class SupportButton extends StatelessWidget {
  final int count;
  final VoidCallback onPressed;
  const SupportButton({Key? key, required this.count, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite_border, semanticLabel: 'Support'),
          const SizedBox(width: 6),
          Text(count.toString()),
        ],
      ),
    );
  }
}
