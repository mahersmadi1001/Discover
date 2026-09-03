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
  @HiveField(3)
  final DateTime? createdAt;
  @HiveField(4)
  final DateTime? lastLogin;
  @HiveField(5)
  final String? phoneNumber;
  @HiveField(6)
  final String? address;
  @HiveField(7)
  final String? profileImageUrl;
  @HiveField(8)
  final int cartCount;
  @HiveField(9)
  final int favoritesCount;

  UserInfoModel({
    required this.id,
    this.name,
    required this.email,
    this.createdAt,
    this.lastLogin,
    this.phoneNumber,
    this.address,
    this.profileImageUrl,
    this.cartCount = 0,
    this.favoritesCount = 0,
  });

  UserInfoModel copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdAt,
    DateTime? lastLogin,
    String? phoneNumber,
    String? address,
    String? profileImageUrl,
    int? cartCount,
    int? favoritesCount,
  }) {
    return UserInfoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      cartCount: cartCount ?? this.cartCount,
      favoritesCount: favoritesCount ?? this.favoritesCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'address': address,
      'profileImageUrl': profileImageUrl,
      'cartCount': cartCount,
      'favoritesCount': favoritesCount,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      lastLogin: map['lastLogin'] != null
          ? DateTime.parse(map['lastLogin'] as String)
          : null,
      phoneNumber: map['phoneNumber'] != null
          ? map['phoneNumber'] as String
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      profileImageUrl: map['profileImageUrl'] != null
          ? map['profileImageUrl'] as String
          : null,
      cartCount: map['cartCount'] as int? ?? 0,
      favoritesCount: map['favoritesCount'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoModel.fromJson(String source) =>
      UserInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserInfoModel(id: $id, name: $name, email: $email, createdAt: $createdAt, lastLogin: $lastLogin, phoneNumber: $phoneNumber, address: $address, profileImageUrl: $profileImageUrl, cartCount: $cartCount, favoritesCount: $favoritesCount)';

  @override
  bool operator ==(covariant UserInfoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.createdAt == createdAt &&
        other.lastLogin == lastLogin &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.profileImageUrl == profileImageUrl &&
        other.cartCount == cartCount &&
        other.favoritesCount == favoritesCount;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      lastLogin.hashCode ^
      phoneNumber.hashCode ^
      address.hashCode ^
      profileImageUrl.hashCode ^
      cartCount.hashCode ^
      favoritesCount.hashCode;
}
