 class UserModelFahmi {
  final String uid;
  final String name;
  final String email;
  final double balance;

  UserModelFahmi({
    required this.uid,
    required this.name,
    required this.email,
    this.balance = 0.0,
  });

  factory UserModelFahmi.fromMap(Map<String, dynamic> m) {
    return UserModelFahmi(
      uid: m['uid'],
      name: m['name'],
      email: m['email'],
      balance: (m['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'balance': balance,
    };
  }
}
