import 'dart:convert';

class ChatUserModel {
  String id;
  String name;
  String email;
  String about;
  String image;
  bool isOnline;
  String createdAt;
  String lastActive;
  String pushToken;
  ChatUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.image,
    required this.isOnline,
    required this.createdAt,
    required this.lastActive,
    required this.pushToken,
  });

  ChatUserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? about,
    String? image,
    bool? isOnline,
    String? createdAt,
    String? lastActive,
    String? pushToken,
  }) {
    return ChatUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      image: image ?? this.image,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      pushToken: pushToken ?? this.pushToken,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'about': about});
    result.addAll({'image': image});
    result.addAll({'is_online': isOnline});
    result.addAll({'created_at': createdAt});
    result.addAll({'last_active': lastActive});
    result.addAll({'push_token': pushToken});

    return result;
  }

  factory ChatUserModel.fromMap(Map<String, dynamic> map) {
    return ChatUserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      about: map['about'] ?? '',
      image: map['image'] ?? '',
      isOnline: map['is_online'] ?? false,
      createdAt: map['created_at'] ?? '',
      lastActive: map['last_active'] ?? '',
      pushToken: map['push_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUserModel.fromJson(String source) =>
      ChatUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatUserModel(id: $id, name: $name, email: $email, about: $about, image: $image, is_online: $isOnline, created_at: $createdAt, last_active: $lastActive, push_token: $pushToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatUserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.about == about &&
        other.image == image &&
        other.isOnline == isOnline &&
        other.createdAt == createdAt &&
        other.lastActive == lastActive &&
        other.pushToken == pushToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        about.hashCode ^
        image.hashCode ^
        isOnline.hashCode ^
        createdAt.hashCode ^
        lastActive.hashCode ^
        pushToken.hashCode;
  }
}
