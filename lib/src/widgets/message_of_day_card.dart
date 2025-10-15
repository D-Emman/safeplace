import 'package:flutter/material.dart';

class MessageOfDayCard extends StatelessWidget {
  final String message;
  final String advice;
  const MessageOfDayCard({Key? key, required this.message, required this.advice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Message of the Day', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(message),
          const SizedBox(height: 12),
          const Text('Advice', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(advice),
        ]),
      ),
    );
  }
}
