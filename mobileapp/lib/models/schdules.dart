// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SchdulesModel {
  String day;
  String room;
  String subject;
  String time;
  SchdulesModel({
    required this.day,
    required this.room,
    required this.subject,
    required this.time,
  });

  SchdulesModel copyWith({
    String? day,
    String? room,
    String? subject,
    String? time,
  }) {
    return SchdulesModel(
      day: day ?? this.day,
      room: room ?? this.room,
      subject: subject ?? this.subject,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'room': room,
      'subject': subject,
      'time': time,
    };
  }

  factory SchdulesModel.fromMap(Map<String, dynamic> map) {
    return SchdulesModel(
      day: (map["day"] ?? '') as String,
      room: (map["room"] ?? '') as String,
      subject: (map["subject"] ?? '') as String,
      time: (map["time"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchdulesModel.fromJson(String source) =>
      SchdulesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SchdulesModel(day: $day, room: $room, subject: $subject, time: $time)';
  }

  @override
  bool operator ==(covariant SchdulesModel other) {
    if (identical(this, other)) return true;

    return other.day == day &&
        other.room == room &&
        other.subject == subject &&
        other.time == time;
  }

  @override
  int get hashCode {
    return day.hashCode ^ room.hashCode ^ subject.hashCode ^ time.hashCode;
  }
}
