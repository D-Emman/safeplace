import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final int streakCount;
  final DateTime? lastActiveDate;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.streakCount,
    this.lastActiveDate,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> map) => UserModel(
    id: id,
    username: map['username'] ?? 'Anonymous',
    email: map['email'] ?? '',
    streakCount: map['streakCount'] ?? 0,
    lastActiveDate: (map['lastActiveDate'] as Timestamp?)?.toDate(),
  );

  Map<String, dynamic> toMap() => {
    'username': username,
    'email': email,
    'streakCount': streakCount,
    'lastActiveDate': lastActiveDate != null ? Timestamp.fromDate(lastActiveDate!.toUtc()) : FieldValue.serverTimestamp(),
  };
}
