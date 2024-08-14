class UserResponse {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  UserResponse({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserResponse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        avatar.hashCode;
  }
}
