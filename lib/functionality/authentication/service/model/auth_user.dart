class AuthUser {
  final String id;
  final String email;

  AuthUser({
    required this.id,
    required this.email,
  });

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      id: map['id'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
    };
  }
}
