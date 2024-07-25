// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResutlModel {}

List<ChatModel> convertToChatModelList(List<Map<String, dynamic>> data) {
  return data.map((map) => ChatModel.fromMap(map)).toList();
}

class ChatModel extends ResutlModel {
  num? id;
  String message;
  bool is_me;
  ChatModel({
     this.id,
    required this.message,
    required this.is_me,
  });

  ChatModel copyWith({
    num? id,
    String? message,
    bool? is_me,
  }) {
    return ChatModel(
      id: id ?? this.id,
      message: message ?? this.message,
      is_me: is_me ?? this.is_me,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'is_me': is_me,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? 0,
      message: map['message'] ?? '',
      is_me: map['is_me'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));

  @override
  String toString() => 'ChatModel(id: $id, message: $message, is_me: $is_me)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChatModel &&
      other.id == id &&
      other.message == message &&
      other.is_me == is_me;
  }

  @override
  int get hashCode => id.hashCode ^ message.hashCode ^ is_me.hashCode;
}
