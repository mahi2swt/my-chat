import 'dart:convert';

class MesssageModel {
  String fromId;
  String toId;
  String msg;
  String read;
  String sent;
  MsgType type;
  MesssageModel({
    required this.fromId,
    required this.toId,
    required this.msg,
    required this.read,
    required this.sent,
    required this.type,
  });

  MesssageModel copyWith({
    String? fromId,
    String? toId,
    String? msg,
    String? read,
    String? sent,
    MsgType? type,
  }) {
    return MesssageModel(
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      msg: msg ?? this.msg,
      read: read ?? this.read,
      sent: sent ?? this.sent,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'fromId': fromId});
    result.addAll({'toId': toId});
    result.addAll({'msg': msg});
    result.addAll({'read': read});
    result.addAll({'sent': sent});
    result.addAll({'type': type.name});

    return result;
  }

  factory MesssageModel.fromMap(Map<String, dynamic> map) {
    return MesssageModel(
      fromId: map['fromId'] ?? '',
      toId: map['toId'] ?? '',
      msg: map['msg'] ?? '',
      read: map['read'] ?? '',
      sent: map['sent'] ?? '',
      type: map['type'] == MsgType.image.name ? MsgType.image : MsgType.text,
    );
  }

  String toJson() => json.encode(toMap());

  factory MesssageModel.fromJson(String source) =>
      MesssageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MesssageModel(fromId: $fromId, toId: $toId, msg: $msg, read: $read, sent: $sent, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MesssageModel &&
        other.fromId == fromId &&
        other.toId == toId &&
        other.msg == msg &&
        other.read == read &&
        other.sent == sent &&
        other.type == type;
  }

  @override
  int get hashCode {
    return fromId.hashCode ^
        toId.hashCode ^
        msg.hashCode ^
        read.hashCode ^
        sent.hashCode ^
        type.hashCode;
  }
}

enum MsgType { text, image }
