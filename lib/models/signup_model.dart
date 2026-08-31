
import 'dart:convert';

class SignupModel {
  final String username;
  final String email;
  final String password;
  SignupModel({
    required this.username,
    required this.email,
    required this.password,
  });

 

  SignupModel copyWith({
    String? username,
    String? email,
    String? password,
  }) {
    return SignupModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) => SignupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignupModel(username: $username, email: $email, password: $password)';

  @override
  bool operator ==(covariant SignupModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ password.hashCode;
}
