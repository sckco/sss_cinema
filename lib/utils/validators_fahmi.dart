bool isValidEmailFahmi(String email) {
  return RegExp(
    r'^[a-zA-Z0-9._%+-]+@poliwangi\.ac\.id$',
    caseSensitive: false,
  ).hasMatch(email);
}

bool isValidPasswordFahmi(String password) {
  return password.length >= 6;
}
