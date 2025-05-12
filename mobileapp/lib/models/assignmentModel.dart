import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentData {
  final String subjectName;
  final String topicName;
  final DateTime assignDate;
  final DateTime lastDate;
  final String status;
   num color;

   AssignmentData({
    required this.color,
    required this.subjectName,
    required this.topicName,
    required this.assignDate,
    required this.lastDate,
    required this.status,
  });

  AssignmentData copyWith({
    String? subjectName,
    String? topicName,
    DateTime? assignDate,
    DateTime? lastDate,
    String? status,
    num? color,
  }) {
    return AssignmentData(
      subjectName: subjectName ?? this.subjectName,
      topicName: topicName ?? this.topicName,
      assignDate: assignDate ?? this.assignDate,
      lastDate: lastDate ?? this.lastDate,
      status: status ?? this.status,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectName': subjectName,
      'topicName': topicName,
      'assignDate': Timestamp.fromDate(assignDate),
      'lastDate': Timestamp.fromDate(lastDate),
      'status': status,
      'color': color,
    };
  }

  factory AssignmentData.fromMap(Map<String, dynamic> map) {
    return AssignmentData(
      subjectName: (map["subjectName"] ?? '') as String,
      topicName: (map["topicName"] ?? '') as String,
      assignDate: (map["assignDate"].toDate()),
      lastDate: (map["lastDate"].toDate()),
      status: (map["status"] ?? '') as String,
      color: (map["color"] ?? '') as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentData.fromJson(String source) =>
      AssignmentData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssignmentData(subjectName: $subjectName, topicName: $topicName, assignDate: $assignDate, lastDate: $color,color: $lastDate, status: $status)';
  }

  @override
  bool operator ==(covariant AssignmentData other) {
    if (identical(this, other)) return true;

    return other.subjectName == subjectName &&
        other.topicName == topicName &&
        other.assignDate == assignDate &&
        other.lastDate == lastDate &&
        other.status == status &&
        other.color == color;
  }

  @override
  int get hashCode {
    return subjectName.hashCode ^
        topicName.hashCode ^
        assignDate.hashCode ^
        lastDate.hashCode ^
        status.hashCode ^
         color.hashCode;
  }
}
