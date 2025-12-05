class UserModelFahmi {
  final String uid;
  final String name;
  final String email;

  UserModelFahmi({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory UserModelFahmi.fromMap(Map<String, dynamic> m) {
    return UserModelFahmi(
      uid: m['uid'],
      name: m['name'],
      email: m['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
