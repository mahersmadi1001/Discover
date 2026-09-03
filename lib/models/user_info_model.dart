import 'dart:convert';
import 'package:hive/hive.dart';
part 'user_info_model.g.dart';

@HiveType(typeId: 1)
class UserInfoModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String email;
  UserInfoModel({required this.id, this.name, required this.email});

  UserInfoModel copyWith({String? id, String? name, String? email}) {
    return UserInfoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'email': email};
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoModel.fromJson(String source) =>
      UserInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserInfoModel(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(covariant UserInfoModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
