/// User model for storing Google Sign-In user information.
///
/// This model handles serialization/deserialization for GetStorage persistence.
class UserModel {
  final String? id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final bool isLoggedIn;

  const UserModel({
    this.id,
    this.displayName,
    this.email,
    this.photoUrl,
    this.isLoggedIn = false,
  });

  factory UserModel.guest() => const UserModel(isLoggedIn: false);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isLoggedIn: json['isLoggedIn'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'isLoggedIn': isLoggedIn,
    };
  }

  UserModel copyWith({
    String? id,
    String? displayName,
    String? email,
    String? photoUrl,
    bool? isLoggedIn,
  }) {
    return UserModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, displayName: $displayName, email: $email, isLoggedIn: $isLoggedIn)';
  }
}
