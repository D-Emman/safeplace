import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String username;
  final String content;
  final List<String> tags;
  final int supportCount;
  final DateTime timestamp;
  final bool isReported;


  PostModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.tags,
    required this.supportCount,
    required this.timestamp,
    required this.isReported,
  });


  factory PostModel.fromMap(String id, Map<String, dynamic> map) => PostModel(
    id: id,
    userId: map['userId'] ?? '',
    username: map['username'] ?? 'Anonymous',
    content: map['content'] ?? '',
    tags: List<String>.from(map['tags'] ?? []),
    supportCount: map['supportCount'] ?? 0,
    timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    isReported: map['isReported'] ?? false,
  );


  Map<String, dynamic> toMap() => {
    'userId': userId,
    'username': username,
    'content': content,
    'tags': tags,
    'supportCount': supportCount,
    'timestamp': FieldValue.serverTimestamp(),
    'isReported': isReported,
  };
}