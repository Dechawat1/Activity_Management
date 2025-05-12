// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  num color_id;
  String creation_data;
  String note_content;
  String note_title;
  String? uid;
   NoteModel({
    required this.color_id,
    required this.creation_data,
    required this.note_content,
    required this.note_title,
     required this.uid,
  });

  NoteModel copyWith({
    num? color_id,
    String? creation_data,
    String? note_content,
    String? note_title,
    String? uid,
  }) {
    return NoteModel(
      color_id: color_id ?? this.color_id,
      creation_data: creation_data ?? this.creation_data,
      note_content: note_content ?? this.note_content,
      note_title: note_title ?? this.note_title,
      uid: uid?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'color_id': color_id,
      'creation_data': creation_data,
      'note_content': note_content,
      'note_title': note_title,
      'uid': uid,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      color_id: (map["color_id"] ?? 0) as num,
      creation_data: (map["creation_data"] ?? '') as String,
      note_content: (map["note_content"] ?? '') as String,
      note_title: (map["note_title"] ?? '') as String,
      uid: (map["uid"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(color_id: $color_id, creation_data: $creation_data, note_content: $note_content, note_title: $note_title, uid: $uid)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.color_id == color_id &&
        other.creation_data == creation_data &&
        other.note_content == note_content &&
        other.note_title == note_title &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return color_id.hashCode ^
        creation_data.hashCode ^
        note_content.hashCode ^
        note_title.hashCode ^
        uid.hashCode;
  }
}
