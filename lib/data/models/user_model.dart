import 'package:appwrite/models.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final bool emailVerification;
  final DateTime? registration;
  final Map<String, dynamic>? prefs;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.emailVerification,
    this.registration,
    this.prefs,
  });

  factory UserModel.fromAppwriteUser(User user) {
    return UserModel(
      id: user.$id,
      email: user.email,
      name: user.name,
      emailVerification: user.emailVerification,
      registration: DateTime.tryParse(user.registration),
      prefs: user.prefs.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'emailVerification': emailVerification,
      'registration': registration?.toIso8601String(),
      'prefs': prefs,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      emailVerification: json['emailVerification'] ?? false,
      registration: json['registration'] != null 
          ? DateTime.tryParse(json['registration']) 
          : null,
      prefs: json['prefs'],
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    bool? emailVerification,
    DateTime? registration,
    Map<String, dynamic>? prefs,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      emailVerification: emailVerification ?? this.emailVerification,
      registration: registration ?? this.registration,
      prefs: prefs ?? this.prefs,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, emailVerification: $emailVerification)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
