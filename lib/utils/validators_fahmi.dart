bool isValidEmailFahmi(String email) {
  return RegExp(r'^[\w\.-]+@poliwangi\.ac\.id$').hasMatch(email);
}

bool isValidPasswordFahmi(String password) {
  return password.length >= 6;
}
