import 'package:cloud_firestore/cloud_firestore.dart';

class DailyContent {
  final DateTime date;
  final String message;
  final String advice;

  DailyContent({required this.date, required this.message, required this.advice});

  factory DailyContent.fromMap(Map<String, dynamic> map) => DailyContent(
    date: (map['date'] as Timestamp).toDate(),
    message: map['message'] ?? '',
    advice: map['advice'] ?? '',
  );

  Map<String, dynamic> toMap() => {
    'date': Timestamp.fromDate(date.toUtc()),
    'message': message,
    'advice': advice,

  };
}
