bool isValidEmailFahmi(String email) {
  return RegExp(r'^[\w\.-]+@student\.univ\.ac\.id$').hasMatch(email);
}

bool isValidPasswordFahmi(String password) {
  return password.length >= 6;
}
